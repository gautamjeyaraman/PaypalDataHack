from twisted.internet import defer
import query
from datetime import datetime
import psycopg2
from cyclone_server.db import cache

'''
WARNING: while manipulating database with emails, please convert it to
lower using python '.lower()' method. It's because, postgres is
case-sensitive. we can use ILIKE to do this, but it is more expensive.
So, even when inserting a new email id, make sure that it is lower
cased before insertion for a better performance during the production.
'''


class PostgresDatabase(object):
    def __init__(self, connection, cache=None):
        self.connection = connection
        self.cache = cache

    def _got_user(self, rows):
        if rows:
            return self._got_users(rows)[0]

    def _got_users(self, rows):
        l = []
        if rows:
            for row in rows:
                usr = User(
                    self, row.id, row.email,
                    row.pw_hash, row.display_name, row.user_name,
                    row.guid, start_date=row.start_date,
                    last_login=row.last_login)
                l.append(usr)
                if self.cache:
                    cache.cache_user(self.cache, usr)
        return l

    def invalidate_user_cache(self, user):
        if self.cache:
            cache.invalidate_user(self.cache, user)

    def invalidate_project_cache(self, project):
        if self.cache:
            cache.invalidate_project(self.cache, project)

    @defer.inlineCallbacks
    def _get_object_from_cache(self, cache_key, serialized=False):
        if not self.cache:
            defer.returnValue(None)
        cached_obj = None
        incache = yield self.cache.contains(cache_key, serialized)
        if incache:
            if serialized:
                cached_obj = yield self.cache.get_serialized(cache_key)
            else:
                cached_obj = yield self.cache[cache_key]
                if cached_obj:
                    cached_obj._db = self
            '''log.msg('Cache key %s in cache %s serialized %s' % (
                cache_key, cached_obj, serialized))
        else:
            log.msg('Not in CACHE %s' % (cache_key, ))'''
        defer.returnValue(cached_obj)

    @defer.inlineCallbacks
    def get_user_by_email(self, email, ignore_cache=False):
        if email is not None:
            email = email.lower()

        user = None

        if not ignore_cache:
            user = yield self._get_object_from_cache(
                    cache.user_prefix_email(email))

        if not user:
            user = yield self._get_user_by_email(email)
        defer.returnValue(user)

    def _get_user_by_email(self, email):
        return self.connection.runQuery(
                query._GET_USER_BY_EMAIL, (email,)).\
                addCallback(self._got_user)

    @defer.inlineCallbacks
    def get_user_by_id(self, user_id, ignore_cache=False):
        if isinstance(user_id, (str, unicode)):
            user_id = int(user_id)

        user = None

        if not ignore_cache:
            user = yield self._get_object_from_cache(
                    cache.user_prefix_id(str(user_id)))

        if not user:
            user = yield self._get_user_by_id(user_id)
        defer.returnValue(user)

    def _get_user_by_id(self, user_id):
        return self.connection.runQuery(
                'SELECT * FROM Person'
                ' WHERE id = %s', (user_id,)).\
                        addCallback(self._got_user)

    @defer.inlineCallbacks
    def get_user_by_guid(self, guid):

        user = yield self._get_object_from_cache(
                cache.user_prefix_guid(guid))

        if not user:
            user = yield self._get_user_by_guid(guid)
        defer.returnValue(user)

    def _get_user_by_guid(self, guid):
        return self.connection.runQuery(
                'SELECT * FROM Person'
                ' WHERE guid = %s', (guid,)).\
                        addCallback(self._got_user)

    @defer.inlineCallbacks
    def get_user_by_username(self, user_name, ignore_cache=False):
        user = None

        if not ignore_cache:
            user = yield self._get_object_from_cache(
                    cache.user_prefix_name(user_name))

        if not user:
            user = yield self._get_user_by_username(user_name)
        defer.returnValue(user)

    def _get_user_by_username(self, user_name):
        return self.connection.runQuery(
            'SELECT * FROM Person WHERE user_name = %s',
            (user_name.lower(),)).\
                    addCallback(self._got_user)

    @defer.inlineCallbacks
    def get_serialized_user_by_id(self, user_id):
        if isinstance(user_id, (str, unicode)):
            user_id = int(user_id)
        user = yield self._get_object_from_cache(
                cache.user_prefix_id(str(user_id)), True)

        if not user:
            user = yield self._get_user_by_id(user_id)
            user = user._serialize()
        defer.returnValue(user)

    @defer.inlineCallbacks
    def _init_new_user(self, person_id, email, timezone):
        yield self.create_my_documents_project(person_id, '#f48d64')
        yield self.create_getting_started_project(person_id, '#77c18e')
        yield self.activity_mail_subscription_entry(person_id, timezone)
        yield self.add_email(person_id, email)

    @defer.inlineCallbacks
    def _person_created(self, r, email, pw_hash, display_name, user_name,
        timezone):
        assert len(r) == 1
        person_id = r[0].id
        person_guid = r[0].guid
        yield self._init_new_user(person_id, email, timezone)
        defer.returnValue(User(
            self, person_id, email, pw_hash,
            display_name, user_name, person_guid))

    def _person_creation_error(self, err):
        print "ERROR CREATING PERSON : %s" % (err,)
        return None

    def _add_user_async(self, guid, email, hashed_pass, display_name, user_name,
        timezone):
        if user_name is not None:
            user_name = user_name.lower()
        return self.connection.runQuery(
            query._ADD_USER_ASYNC,
            (guid, email.lower(), hashed_pass, display_name, user_name, timezone)).\
            addCallback(
                self._person_created, email=email, pw_hash=hashed_pass,
                display_name=display_name, user_name=user_name,
                timezone=timezone).\
            addErrback(self._person_creation_error)

    def _got_temp_user(self, r):
        if r:
            return self._got_temp_users(r)[0]
        return r

    def add_temp_user(self, email, guid=None):
        return self.connection.runQuery(
            query._ADD_TEMP_USER,
            (email.lower(),guid)).\
            addCallback(self._got_temp_user).\
            addErrback(self._person_creation_error)

    def _got_temp_users(self, rows):
        l = []
        if rows:
            for row in rows:
                l.append(User(
                    self, row.person_id, row.email,
                    row.guid))
        return l

    def get_temp_users_by_email(self, email):
        return self.connection.runQuery(
            query._GET_TEMP_USER_BY_EMAIL, (email.lower(),)).\
            addCallback(self._got_temp_users)

    def get_temp_user_by_guid(self, guid):
        return self.connection.runQuery(
            query._GET_TEMP_USER_BY_GUID,
            (guid,)).\
            addCallback(self._got_temp_user)

    @defer.inlineCallbacks
    def add_user(self, guid, email, hashed_pass, user_name, display_name=None,
        timezone='UTC'):
        res = yield self._add_user_async(
            guid, email, hashed_pass, display_name, user_name, timezone)
        defer.returnValue(res)

    @defer.inlineCallbacks
    def remove_temp_user(self, email):
        yield self.connection.runOperation(
            'DELETE FROM tempemail WHERE email = %s',
            (email.lower(),)).\
            addCallback(lambda x: (True,))

    def set_last_login(self, user_id):
        last_login = datetime.utcnow()
        return self.connection.runOperation(
            query.SET_LAST_LOGIN, (last_login, user_id))

    def set_last_login_by_guid(self, user_guid):
        last_login = datetime.utcnow()
        return self.connection.runOperation(
            query.SET_LAST_LOGIN_BY_GUID, (last_login, user_guid))

    def get_last_login(self, user_id):
        return self.connection.runQuery(
            query.GET_LAST_LOGIN, (user_id,)).addCallback(
                lambda x: x[0].last_login)

    def get_disquery_by_user(self, user_id):
        return self.connection.runQuery(
            query.GET_DISQUERY_BY_USER, (user_id,)).\
            addCallback(self._get_disquery).\
            addErrback(lambda x: None)

    def get_disquery_by_guid(self, guid):
        return self.connection.runQuery(
            query.GET_DISQUERY_BY_GUID, (guid, )).\
            addCallback(self._got_disquery).\
            addErrback(None)

    def get_disquery_meta_by_guid(self, guid):
        return self.connection.runQuery(
            query.GET_DISQUERY_META_BY_GUID, (guid, )).\
            addCallback(self._got_disquery).\
            addErrback(None)

    def _got_disquery(self, r):
        if r and len(r) != 0:
            return r[0]
        else:
            return None

    def get_playback_by_guid(self, guid):
        return self.connection.runQuery(
            query.GET_PLAYBACK_BY_GUID, (guid, )).\
            addCallback(lambda x: x[0]).\
            addErrback(None)

    def insert_new_disquery(self, guid, name, user_id):
        if name:
            return self.connection.runQuery(
                query.INSERT_NEW_DISQUERY, (guid, name, user_id)).\
                addCallback(lambda x: x[0]).\
                addErrback(lambda x: False)
        else:
            return self.connection.runQuery(
                query.INSERT_NEW_DISQUERY, (guid, name, user_id)).\
                addCallback(self.update_new_disquery_name).\
                addErrback(lambda x: False)

    def update_new_disquery_name(self, x):
        x = x[0]
        name = 'Untitled'
        return self.connection.runQuery(
            query.UPDATE_NEW_DISQUERY_NAME, (name, x.id)).\
            addCallback(lambda x: x[0]).\
            addErrback(lambda x: False)

    def insert_new_public_disquery(self, dq, dqData, user, dq_hash=None, notes=None):
        return self.connection.runQuery(
            query.INSERT_NEW_PUBLIC_DISQUERY, (
                dq.id, user.user_name, dq.name, dq_hash,
                dqData, dq.playbackdata, notes, dq.document_count,
                dq.location_count, dq.person_count,
                dq.organisation_count, dq.keyword_count)).\
            addCallback(lambda x: x[0]).\
            addErrback(self._got_Error)

    def get_public_disquery_by_guid(self, user_name, disquery_guid):
        return self.connection.runQuery(
            query.GET_PUBLIC_DISQUERY_BY_GUID, (user_name, disquery_guid))

    def get_public_disquery_meta_by_guid(self, user_name, disquery_guid):
        return self.connection.runQuery(
            query.GET_PUBLIC_DISQUERY_META_BY_GUID, (user_name, disquery_guid))

    def get_public_disquery_by_hash(self, user_name, dq_hash):
        return self.connection.runQuery(
            query.GET_PUBLIC_DISQUERY_BY_HASH, (user_name, dq_hash))

    def update_disquery_data(self, node_count, guid, user_id):
        return self.connection.runOperation(
            query.UPDATE_DISQUERY_DATA, (
                node_count.get('document', 0),
                node_count.get('location', 0),
                node_count.get('person', 0),
                node_count.get('organization', 0),
                node_count.get('keyword', 0),
                guid, user_id)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def update_playback_data(self, data, guid, user_id):
        return self.connection.runOperation(
            query.UPDATE_PLAYBACK_DATA, (data, guid, user_id)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def update_disquery_name(self, name, guid, user_id):
        return self.connection.runQuery(
            query.UPDATE_DISQUERY_NAME, (name, guid, user_id)).\
            addCallback(self._get_single).\
            addErrback(lambda x: False)

    def get_cust_report(self):
        return self.connection.runQuery(
            query._GET_CUST_REPORT)

    def get_version_ids_from_guids(self, ver_guids):
        vg = tuple(ver_guids)
        return self.connection.runQuery(
            query.GET_VER_GUIDS_FROM_IDS, (vg, ))

    def remove_dq_with_public(self, d_guid, user):
        return self.connection.runQuery(
            query.RM_DQ_WITH_PUBLIC, (d_guid, d_guid, user.user_name,
                                      d_guid, user._id)).\
            addCallback(self._get_single).\
            addErrback(lambda x: None)

    def remove_dq_without_public(self, d_guid, user):
        return self.connection.runQuery(
            query.RM_DQ_WITHOUT_PUBLIC, (d_guid, d_guid, user.user_name,
                                         d_guid, user._id)).\
            addCallback(self._get_single).\
            addErrback(lambda x: None)

    def add_note_to_disquery(self, note, key, guid, n_type, created_by):
        return self.connection.runQuery(
            query.ADD_DISQUERY_NOTE, (guid, key, note, n_type, created_by)).\
            addCallback(self._got_disquery_notes).\
            addCallback(self._get_single).\
            addErrback(lambda x: False)

    def get_disquery_notes(self, guid):
        return self.connection.runQuery(
            query.GET_DISQUERY_NOTES, (guid, )).\
            addCallback(self._got_disquery_notes).\
            addErrback(lambda x: None)

    def get_disquery_guid_from_note_guid(self, note_guid):
        return self.connection.runQuery(
            query.GET_DQ_GUID_FROM_NOTE, (note_guid, )).\
            addCallback(self._get_single).\
            addErrback(lambda x: None)

    def _got_disquery_notes(self, rows):
        l = []
        if rows:
            for row in rows:
                note = DisqueryNote(self, row.id, row.guid, row.dq_id,
                                    row.note_key, row.type, row.fragment,
                                    row.created_on, row.created_by)
                l.append(note)
        return l

    def get_invalid_login_attempts_count(self, user_id):
        return self.connection.runQuery(query._GET_CONSECUTIVE_INVALID_LOGINS_COUNT,\
                (user_id,)).addErrback(lambda x: False)

    def get_user_login_blocked_time(self, user_id):
        return self.connection.runQuery(query._GET_LOGIN_BLOCKED_ON, (user_id,)).\
                addErrback(lambda x: False)

    def set_block_login_time(self, user_id):
        return self.connection.runOperation(query._SET_BLOCK_LOGIN_TIME, (user_id,)).\
                addCallback(lambda x: True).\
                addErrback(lambda x: False)

    def reset_invalid_login_info(self, user_id):
        return self.connection.runOperation(query._RESET_INVALID_LOGIN_INFO, (user_id,)).\
                addCallback(lambda x: True).\
                addErrback(lambda x: False)

    def update_failed_login_attempts_count(self, user_id):
        return self.connection.runOperation(query._INCR_FAILED_LOGIN, (user_id,)).\
                addCallback(lambda x: True).\
                addErrback(lambda x: False)

    def _got_Error(self, r):
        print "ERROR POSTGRES : %s" % (r,)
        return r

    def _get_disquery(self, rows):
        l = []
        if rows:
            for row in rows:
                d = Disquery(self, row.id, row.guid, row.name, row.person_id,
                                    row.location_count, row.person_count,
                                    row.organisation_count, row.document_count,
                                    row.keyword_count, row.created_on)
                l.append(d)
        return l

    def insert_feed_subscription(self, feed_id, title, url,
                                 thumbnail):
        return self.connection.runOperation(
            query._INSERT_FEED_SUBSCRIPTION,
            (feed_id, title, url, thumbnail, feed_id)).\
            addCallback(lambda x: x[0].feed_id if x else None).\
            addErrback(self._got_Error)

    def insert_feed_subscription_by_user_id(self, feed_id, person_id):
        return self.connection.runOperation(
            query._INSERT_FEED_SUBSCRIPTION_BY_USER_ID,
            (feed_id, person_id, feed_id, person_id, feed_id, person_id)).\
            addCallback(lambda x: x[0].feed_id if x else None).\
            addErrback(self._got_Error)

    def get_user_subscriptions_by_user_id(self, user_id):
        return self.connection.runQuery(
            query._GET_USER_SUBSCRIPTION_BY_USER_ID, (user_id,))

    def remove_feed_subscription(self, feed_id, user_id):
        return self.connection.runOperation(
            query._REMOVE_FEED_SUBSCRIPTION, 
            (feed_id, user_id)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def get_feed_subscription_by_feed_id(self, feed_id, user_id):
        return self.connection.runQuery(
            query._GET_FEED_SUBSCRIPTION_BY_FEED_ID, (feed_id, user_id))

    def get_periodic_activity_sentiments_by_project(self, project_id, period):
        return self.connection.runQuery("SELECT * FROM fetch_periodic_activity_sentiments('%s', %s)"
                % (period, project_id)).\
                    addCallback(self._got_periodic_activity_sentiments_by_project).\
                    addErrback(self._got_Error)

    def _got_periodic_activity_sentiments_by_project(self, rows):
        l = []
        if rows:
            for row in rows:
                l.append({'date': row.start_date, 'Pos': float(row.pos), 'Neg': 100.0 - float(row.pos),
                    'activity_count': row.act_count})
        return l

    def get_document_count_by_project_id(self, project_id):
        return self.connection.runQuery(
            query._GET_DOCUMENT_COUNT_BY_PROJECT_ID, (project_id,)).\
            addCallback(lambda x: x[0].count).\
            addErrback(lambda x: False)

    def get_all_invalid_users(self, user_ids):
        user_ids = tuple(user_ids)
        return self.connection.runQuery(
            query.GET_ALL_INVALID_USERS, (user_ids, ))


    def get_overall_activity_sentiments_by_user_id(self, user_id):
        return self.connection.runQuery("SELECT * FROM fetch_overall_activity_sentiments(%s)"
                % (user_id)).\
                addCallback(self._got_periodic_activity_sentiments_by_project).\
                addErrback(self._got_Error)

    def add_temp_file(self, filepath, parent_guid=None, file_type=None):
        filedata = open(filepath, 'rb').read()
        return self.connection.runQuery(
            query._INSERT_TEMP_FILE,
            (psycopg2.Binary(filedata), parent_guid, file_type)).\
            addCallback(self._temp_file_added).\
            addErrback(lambda x: False)

    def update_temp_file(self, file_id, version_guid):
        return self.connection.runOperation(
            query._UPDATE_TEMP_FILE,
            (version_guid, file_id,)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def remove_old_temp_file(self, user_guid):
        return self.connection.runOperation(
            query._DELETE_TEMP_FILE,
            (user_guid, )).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def _temp_file_added(self, r):
        x = None
        if isinstance(r, list):
            if len(r) > 0:
                x = r[0]
        else:
            x = r
        return x.id

    def get_temp_file(self, fileid):
        return self.connection.runQuery(
            query._GET_TEMP_FILE, (fileid,)).\
            addCallback(self._got_temp_file).\
            addErrback(lambda x: False)

    def get_temp_file_by_parent_guid(self, parent_guid):
        return self.connection.runQuery(
            query._GET_TEMP_FILE_BY_PARENT_GUID, (parent_guid, )).\
            addCallback(self._got_temp_file_record).\
            addErrback(lambda x: False)

    def _got_temp_file_record(self, r):
        if isinstance(r, list):
            if len(r) > 0:
                return r[0]
            else:
                return r
        return None

    def _got_temp_file(self, r):
        x = None
        if isinstance(r, list):
            if len(r) > 0:
                x = r[0]
            else:
                x = r
        return x.file_data

    def get_user_watchwords(self, user_id):
        return self.connection.runQuery(
            query.GET_WATCH_WORDS, (user_id, )).\
            addCallback(self._got_watchwords).\
            addErrback(lambda x: None)

    def _got_watchwords(self, rows):
        l = []
        if rows:
            for row in rows:
                l.append({'term': row.watchterm,
                          'type': row.type})
        return l

    def add_watch_word(self, user_id, word, word_type):
        return self.connection.runOperation(
            query.ADD_WATCH_WORD, (user_id, word, word_type)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def remove_watch_word_custom_only(self, user_id, word):
        return self.connection.runOperation(
            query.RM_WATCH_WORD_CUSTOM_ONLY, (user_id, word, 'custom',
                                  user_id, word, 'custom')).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def remove_watch_word(self, user_id, word, word_type):
        return self.connection.runOperation(
            query.RM_WATCH_WORD, (user_id, word, word_type,
                                  user_id, word, 'custom',
                                  user_id, word, word_type,
                                  user_id, word, 'custom')).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def _got_project(self, r):
        x = None
        if isinstance(r, list):
            if len(r) > 0:
                x = r[0]
        else:
            x = r
        if x:
            prj = Project(self, x.id, x.guid, x.person_id,
                            x.project_name, x.created_on,
                            x.color, x.updated_on)
            if self.cache:
                cache.cache_project(self.cache, prj)
            return prj
    
    def _got_projid_list(self, pl):
        return map(self._got_project, pl)
    
    def list_user_projects(self, user_id):
        return self.connection.runQuery(
            query._LIST_USER_PROJECTS, (user_id, user_id)).\
            addCallback(self._got_projid_list)

    def get_all_userdocs_with_vguid(self, user_id, limit=10, offset=0):
        return self.connection.runQuery(query._USER_DOCS_DQ,
            (user_id, user_id, limit, offset))


    def _check_access(self, r):
        if isinstance(r, list) and len(r) > 0:
            return True
        else:
            return False

    def has_access_to_project_by_guid(self, project_guid, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_PROJECT_BY_GUID,
                (project_guid, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_project_by_id(self, project_id, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_PROJECT_BY_ID,
                (project_id, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_document_by_guid(self, doc_guid, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_DOCUMENT_BY_GUID,
                (doc_guid, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_document_by_id(self, doc_id, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_DOCUMENT_BY_ID,
                (doc_id, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_task_by_guid(self, task_guid, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_TASK_BY_GUID,
                (task_guid, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_task_by_id(self, task_id, user_id):
        return self.connection.runQuery(query.CHECK_ACCESS_TO_TASK_BY_ID,
                (task_id, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_documentversion_by_guid(self, doc_ver_guid, user_id):
        return self.connection.runQuery(
                query.CHECK_ACCESS_TO_DOCUMENT_VERSION_BY_GUID,
                (doc_ver_guid, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_documentversion_by_id(self, doc_ver_id, user_id):
        return self.connection.runQuery(
                query.CHECK_ACCESS_TO_DOCUMENT_VERSION_BY_ID,
                (doc_ver_id, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_annotation_by_guid(self, annotation_guid, user_id):
        return self.connection.runQuery(
                query.CHECK_ACCESS_TO_ANNOTATION_BY_GUID,
                (annotation_guid, user_id, user_id)).addCallback(
                        self._check_access)

    def has_access_to_annotation_by_id(self, annotation_id, user_id):
        return self.connection.runQuery(
                query.CHECK_ACCESS_TO_ANNOTATION_BY_ID,
                (annotation_id, user_id, user_id)).addCallback(
                        self._check_access)

    def _got_document(self, r):
        x = None
        if isinstance(r, list):
            if len(r) > 0:
                x = r[0]
        else:
            x = r
        if x:
            return Document(
                self, x.id, x.guid, x.title, x.owner_id,
                x.deleted, x.project_id,
                x.document_type, 
                x.thumbnails if hasattr(x, 'thumbnails') else None)

    def _got_documents(self, r):
        lst = []
        for x in r:
            lst.append(Document(self, x.id, x.guid, x.title,
                        x.owner_id, x.deleted, x.project_id,
                        x.document_type))
        return lst 
                
    def _got_docid_list(self, dl):
        return map(self._got_document, dl)
                
    def list_proj_docs_with_limit(self, guid, limit, offset):
        return self.connection.runQuery(
            query._PROJECT_DOCS_WITH_LIMIT, (guid, limit, offset)).\
            addCallback(self._got_docid_list)

    def list_proj_docs(self, guid):
        return self.connection.runQuery(
            query._PROJECT_DOCS, (guid,)).\
            addCallback(self._got_docid_list)

    def _got_doc_versions(self, r, full=False):
        l = []
        if len(r) > 0:
            for o in r:
                d = DocumentVersion(
                    self, o.id, o.guid,
                    o.version, o.file_hash,
                    _pages=o.pages, _title=o.title,
                    _author=o.author, _uploaded_by=o.uploaded_by,
                    _uploaded_on=o.uploaded_on,
                    _upload_type=o.upload_type, _s3_bucket=o.s3_bucket,
                    _s3_key=o.s3_key, 
                    _document_id=o.document_id, _summary=o.summary,
                    _source=o.source, 
                    _status=o.status)
                l.append(d)
        return l

    def get_document_versions(self, doc_id, getAll=True):
        d = self.connection.runQuery(
            query._DOC_VERSIONS, (doc_id,)).\
            addCallback(self._got_doc_versions, full=getAll)
        return d
  
    @defer.inlineCallbacks
    def get_serialized_project_by_id(self, project_id):
        if isinstance(project_id, (str, unicode)):
            project_id = int(project_id)
        project = yield self._get_object_from_cache(
                cache.project_prefix_id(str(project_id)), True)

        if not project:
            project = yield self._get_project_by_id(project_id)
            project = yield project._serialize()
        defer.returnValue(project)

    def get_source_type_by_version_id(self, version_id):
        return self.connection.runQuery(
            query._GET_SOURCE_TYPE_BY_VERSION_ID, (version_id,)).\
            addCallback(lambda x: x[0].type).\
            addErrback(lambda x: False)

    def _get_single(self, r):
        if isinstance(r, list) and len(r) > 0:
            return r[0]

    def _get_id(self, r):
        x = None
        if isinstance(r, list):
            if len(r) > 0:
                x = r[0]
        else:
            x = r
        return x.id
    
    def add_to_index_queue(self, data, url, deletion):
        return self.connection.runQuery(
            query._ADD_TO_INDEX_QUEUE, (
                data, url, deletion)).\
            addCallback(self._get_id).\
            addErrback(lambda x: False)

    def get_all_userdocs(self, user_id, limit=10, offset=0):
        return self.connection.runQuery(query._USER_DOCS_DQ,
            (user_id, user_id, limit, offset)).\
            addCallback(self._got_docid_list).\
            addErrback(lambda x: None)

    def _get_doc_version_summary(self, rows):
        l = []
        for row in rows:
            l.append(DocumentsKeyword(self, row.guid, row.summary))
        return l
    
    def get_doc_version_summary(self, docVersionguid):
        return self.connection.runQuery(
            query._GET_DOC_VERSION_SUMMARY, (docVersionguid,)).\
            addCallback(self._get_doc_version_summary)

    def list_latest_documents(self, user_id, limit, offset):
            return self.connection.runQuery(
                query._USER_LATEST_DOCS, (user_id, limit, offset)).\
                addCallback(self._got_docid_list)
                
    def get_all_documents_count_by_user_id(self, user_id):
        return self.connection.runQuery(
            query._GET_ALL_DOCUMENTS_COUNT_BY_USER_ID, (user_id)).\
            addCallback(lambda x: x[0].count).\
            addErrback(lambda x: False)
            
    def get_failed_doc_retry_count(self, version_id):
        return self.connection.runQuery(
            query._GET_FAILED_DOC_RETRY_COUNT, (version_id, )).\
            addCallback(lambda x: x[0].count).\
            addErrback(lambda x: False)
            
    def add_ftp_ac(self, person_id, project_id, src_type, user_name, password, source_path, port, sync, title):
        return self.connection.runQuery(
            query._INSERT_NEW_FTP_AC,
            (person_id, project_id, src_type, user_name, password, source_path, port, sync, title)).\
            addCallback(self._got_ftp_settings).\
            addErrback(self._got_Error)

    def get_ftp_settings(self, user_id):
        return self.connection.runQuery(
            query._GET_FTP_SETTINGS, (user_id, )).\
            addCallback(self._got_ftp_settings).\
            addErrback(lambda x: None)

    def _got_ftp_settings(self, rows):
        l = []
        if rows:
            for row in rows:
                l.append({'id': row.id, 'guid': row.guid,  'source_path': row.source_path, 'title': row.title})
        return l
    
    def remove_ftp_setting(self, ftp_id, user_id):
        return self.connection.runOperation(
            query._REMOVE_FTP_SETTING, (ftp_id, user_id)).\
            addCallback(lambda x: True).\
            addErrback(self._got_Error)

    def _got_doc_sources(self, r):
        l = []
        if len(r) > 0:
            for o in r:
                d = DocumentSource(
                    self, _id=o.id, _guid=o.guid, _person_id=o.person_id,
                    _title=o.title,
                    _access_token=o.access_token,
                    _access_token_secret=o.access_token_secret,
                    _user_id=o.user_id, _user_name=o.user_name,
                    _email=o.email, _server=o.server, _port=o.port,
                    _usessl=o.usessl, _password=o.password,
                    _added_on=o.added_on, _updated_on=o.updated_on,
                    _folder_id=o.folder_id, _data_id=o.data_id,
                    _status=o.status,
                    _ftpurl = o.url)
                l.append(d)
        return l

    def get_document_sources_by_user_id(self, user_id):
        d = self.connection.runQuery(
            query._GET_DOCUMENT_SOURCE_BY_USER_ID, (user_id,user_id)).\
            addCallback(self._got_doc_sources)
        return d

    @defer.inlineCallbacks
    def get_project_by_guid(self, project_guid):
        project = yield self._get_object_from_cache(
                cache.project_prefix_guid(project_guid))
        if not project:
            project = yield self._get_project_by_guid(project_guid)
        defer.returnValue(project)

    def _get_project_by_guid(self, project_guid):
        return self.connection.runQuery(
            query._GET_PROJECT_BY_GUID, (project_guid,)).\
            addCallback(self._got_project)

    def list_projects(self, user_id):
        return self.connection.runQuery(
            query._USER_PROJS, (user_id,)).\
            addCallback(self._got_projects)
            
    def _got_projects(self, rows):
        l = []
        if rows:
            for x in rows:
                l.append(Project(self, x.id, x.guid,
                         x.person_id, x.project_name,
                         x.created_on, x.color, x.updated_on))
        return l
                
    def add_sync_slots(self, sync_mins, ds_id):
        return self.connection.runOperation(
            query._ADD_SYNC_SLOTS, (sync_mins, ds_id)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def remove_sync_slots(self, ds_id):
        return self.connection.runOperation(
            query._REMOVE_SYNC_SLOT, (ds_id,)).\
            addCallback(lambda x: True).\
            addErrback(self._got_Error)
            
    def get_ftp_settings_guid(self, guid):
        return self.connection.runQuery(
            query._GET_FTP_SETTINGS_GUID, (guid, )).\
            addCallback(self._got_ftp_settings).\
            addErrback(lambda x: None)

    def get_search_terms_by_user_id(self, user_id, limit, offset):
        return self.connection.runQuery(
            query._GET_SEARCH_TERMS_BY_USER_ID, (
                user_id, limit, offset)).\
            addCallback(self._got_search_terms).\
            addErrback(lambda x: False)

    def _got_search_terms(self, rows):
        l = []
        if rows:
            for x in rows:
                l.append(x.search_term)
        return l

    def insert_or_update_search_terms_by_user_id(self, user_id, search_term):
        return self.connection.runOperation(
            query._INSERT_OR_UPDATE_SEARCH_TERMS_BY_USER_ID, (user_id, 
            search_term, user_id, search_term, user_id, search_term)).\
            addCallback(lambda x: True).\
            addErrback(lambda x : False)

    def get_article_sentences_by_article_id(self, article_id):
        return self.connection.runQuery(
            query._GET_ARTICLE_SENTENCE_BY_ARTICLE_ID, (article_id,)).\
            addCallback(self._got_article).\
            addErrback(lambda x: False)

    def _got_article(self, rows):
        l = []
        if rows:
            article_date = rows[0].article_date.strftime('%a, %d %b %Y %I:%M%p')
            for row in rows:
                l.append({'id': row.id, 'article_date': article_date,
                          'source_url': row.source_url, 'title': row.title,
                          'sentence': row.sentence, 'lexicon_match': row.lexicon_match,
                          'sentence_id': row.sentence_id, 'lexicon_acq': row.lexicon_acq,
                          'lexicon_vnsp': row.lexicon_vnsp, 'lexicon_nc': row.lexicon_nc,
                          'lexicon_job': row.lexicon_job})
        return l

    def insert_or_update_classified_sent(self, ACQ, VNSP, JOB, NC, subjective, is_ignored, user_id, sent_id):
        return self.connection.runOperation(
            query._INSERT_OR_UPDATE_CLASSIFIED_SENT, (ACQ, VNSP, JOB,
            NC, subjective, is_ignored, user_id, sent_id, ACQ, VNSP, JOB,
            NC, subjective, is_ignored, user_id, sent_id, user_id, sent_id)).\
            addCallback(lambda x: True).\
            addErrback(lambda x: False)

    def get_article_sentences(self, limit):
        return self.connection.runQuery(
            query._GET_ARTICLE_SENTENCES).\
            addCallback(self._got_article).\
            addErrback(lambda x : False)

    def get_article_with_date_range(self, start_date):
        return self.connection.runQuery(
            query._GET_ARTICLE_WITH_DATE_RANGE, (start_date,)).\
            addCallback(self._got_article).\
            addErrback(lambda x : False)

    def get_list_of_merchant(self):
        return self.connection.runQuery(
            query._GET_LIST_OF_MERCHANT).\
            addCallback(self._got_merchant_list)
            
    def _got_merchant_list(self, rows):
        l = []
        if rows:
            for row in rows:
                l.append({'id': row.id, 'merchant_name': name,
                         'merchant_sentiment' : sentiment, 'merchant_count' :count})
        return l

    def get_merchant_product_list_by_merchant_id(self, merchant_id):
        return self.connection.runQuery(
            query._GET_COLLABORATIVE_FILTERING_BY_MERCHANT_ID, (merchant_id, merchant_id)).\
            addCallback(lambda x : [row[0] for row in x]).\
            addErrback(lambda x : False)

                
    

