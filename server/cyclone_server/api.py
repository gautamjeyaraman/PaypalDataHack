import json
from twisted.python import log

import cyclone
from cyclone_server.db import mixin
from cyclone_server import utils 
from cyclone_server.utils import BaseHandler
from cyclone_server.db.mixin import DatabaseMixin
from cyclone_server import config
from twisted.internet import defer

class APIBase(BaseHandler, DatabaseMixin):
    no_xsrf = True

    def get_config(self):
        path = config.config_file_path()
        settings = config.parse_config(path)
        return settings

    def prepare(self):
        self.set_header("Content-Type", "application/json")
        self.set_header("Cache-Control", "no-cache")

    def write_json(self, d):
        self.set_header("Content-Type", "application/json")
        return self.write(json.dumps(d, sort_keys=True, indent=4))

class AuthCheck(APIBase):
    def get(self):
        user = self.current_user
        display_name = user.display_name
        if display_name is None:
            display_name = 'Default User'
        response_dict = {
            'authenticated': True,
            'user_id': user._id,
            'email': user.email,
            'display_name': user.display_name,
            'user_name': user.user_name,
            'user_guid': user.user_guid
        }
        device_token = self.get_argument('deviceToken', None)
        if device_token:
            isapns = self.get_argument('is_apns', None)
            log.msg('adding device token %s' % (device_token,))
            self.database.add_device_token(device_token, isapns, user)
            if len(device_token) == 64:
                self.urbanairship.register(device_token)
        return self.write_json(response_dict)


class CollaborativeFilteringHandler(APIBase):
    @defer.inlineCallbacks
    def get(self):
        merchant_id = self.get_argument('merchant_id')
        productNamesList = yield self.database.get_merchant_product_list_by_merchant_id(merchant_id)
        defer.returnValue(self.write_json(productNamesList))

