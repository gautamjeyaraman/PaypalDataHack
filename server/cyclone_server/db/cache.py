import cPickle as pickle
from twisted.internet import defer
import json
expiry = 7200

serialized_suffix = '-ser'


class BaseCache(object):
    _cache = dict()
    _serializer = pickle

    def _serial(self, obj):
        return self._serializer.dumps(obj)

    def _unserial(self, string):
        return self._serializer.loads(str(string))

    def __contains__(self, item):
        """
        :param item: Key
        :rtype: bool
        """
        raise NotImplementedError(
                "def __contains__ -- %s" % self.__class__.__name__)

    def __getitem__(self, key):
        """
        :param str key: key name
        :rtype: list
        """
        raise NotImplementedError(
                "def __getitem__ -- %s" % self.__class__.__name__)

    def __setitem__(self, key, message):
        """
        :param str key: key name
        :param list message: value
        """
        raise NotImplementedError(
                "def __setitem__ -- %s" % self.__class__.__name__)

    def keylen(self, key):
        """
        :param str key: key name
        :rtype: int
        """
        raise NotImplementedError("def keylen -- %s" % self.__class__.__name__)

    def extend(self, key, message):
        """
        :param str key: key name
        :param list message: value
        """
        raise NotImplementedError("def extend -- %s" % self.__class__.__name__)


class RedisCache(BaseCache):
    def __init__(self, conf):
        from cyclone import redis as cyredis
        conn = cyredis.ConnectionPool(
                conf.host, conf.port, conf.dbid, conf.poolsize)
        conn.addCallback(lambda c: setattr(self,
            '_cache', c))

    def contains(self, item, serialized=False):
        if serialized:
            item += serialized_suffix
        return self._cache.exists(item)

    def delete(self, key, serialized=False):
        if serialized:
            key += serialized_suffix
        print 'Deleting Cache Key ' + key
        if self._cache.exists(key):
            self._cache.delete(key)

    def __contains__(self, item):
        return self._cache.exists(item)

    def _got_item(self, item, serialized=False):
        if item:
            if serialized:
                return json.loads(item)
            else:
                return self._unserial(item)
        return None

    def __getitem__(self, key):
        return self._cache.hget(
                key, 'data').addCallback(
                self._got_item, False)

    @defer.inlineCallbacks
    def __setitem__(self, key, message):
        if self._cache.exists(key):
            yield self._cache.delete(key)
        self.extend(key, message)

    @defer.inlineCallbacks
    def set_serialized(self, key, obj_dict):
        key += serialized_suffix
        if self._cache.exists(key):
            yield self._cache.delete(key)
        self.extend(key, obj_dict, True)

    def get_serialized(self, key):
        key += serialized_suffix
        return self._cache.hget(
                key, 'data').addCallback(
                        self._got_item, serialized=True)

    def keylen(self, key):
        return self._cache.llen(key)

    @defer.inlineCallbacks
    def extend(self, key, message, serialized=False):
        if serialized:
            yield self._cache.hset(key, 'data', json.dumps(message))
        else:
            yield self._cache.hset(key, 'data', self._serial(message))
        self._cache.expire(key, expiry)

    def __delitem__(self, key):
        return self._cache.delete(key)

    def invalidate(self, key):
        return self._cache.delete(key)


def cache_user(cache_ins, user):
    cache_ins[user_prefix_guid(user.user_guid)] = user
    cache_ins[user_prefix_name(user.user_name)] = user
    cache_ins[user_prefix_email(user.email)] = user
    cache_ins[user_prefix_id(user._id)] = user
    cache_ins.set_serialized(user_prefix_id(user._id),
            user._serialize())


def invalidate_user(cache_ins, user):
    cache_ins.delete(user_prefix_guid(user.user_guid))
    cache_ins.delete(user_prefix_name(user.user_name))
    cache_ins.delete(user_prefix_email(user.email))
    cache_ins.delete(user_prefix_id(user._id))
    cache_ins.delete(user_prefix_id(user._id), True)


def cache_project(cache_ins, project):
    cache_ins[project_prefix_guid(project.guid)] = project
    cache_ins[project_prefix_id(project._id)] = project
    project._serialize().addCallback(_got_serialized_project,
            cache_ins, project._id)


def invalidate_project(cache_ins, project):
    cache_ins.delete(project_prefix_guid(project.guid))
    cache_ins.delete(project_prefix_id(project._id))
    cache_ins.delete(project_prefix_id(project._id), True)


def _got_serialized_project(serialized_project, cache_ins, project_id):
    cache_ins.set_serialized(project_prefix_id(project_id),
            serialized_project)


def project_prefix_guid(prj_guid):
    return 'prj:%s' % prj_guid


def project_prefix_id(prj_id):
    return 'prj:id-%s' % prj_id


def user_prefix_guid(user_guid):
    return 'user:%s' % user_guid


def user_prefix_id(user_id):
    return 'user:id-%s' % user_id


def user_prefix_email(email):
    return 'user:em-%s' % email


def user_prefix_name(user_name):
    return 'user:un-%s' % user_name
