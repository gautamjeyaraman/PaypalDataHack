from twisted.internet import reactor

from txmongo._pymongo.objectid import ObjectId

from .objects import User
class MongoDatabase(object):
    def __init__(self, connection, cache):
        self.connection = connection
        self.cache = cache

    def _got_user(self, docs):
        if docs:
            doc = docs[0]
            return User(self, doc['_id'], doc['email'], doc['pwhash'])

    def get_user_by_email(self, email):
        return self.connection.users.find(
                {'email': email}, limit=1).addCallback(
                        self._got_user)

    def get_user_by_id(self, user_id):
        oid = ObjectId(user_id)
        return self.connection.users.find(
                {'_id': oid}, limit=1).addCallback(
                        self._got_user)
    
    def rm_user(self, email):
        if reactor.running:
            raise NotImplementedError("async version not implemented")
        self.connection.users.remove({'email': email})

    def list_users(self):
        if reactor.running:
            raise NotImplementedError("async version not implemented")
        for u in self.connection.users.find():
            yield self._got_user([u])
