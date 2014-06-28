import re
from twisted.internet import defer
from cyclone_server import utils
from cyclone_server.utils import BaseHandler, incrementPageView
from cyclone_server.db.mixin import DatabaseMixin

class IndexHandler(BaseHandler, DatabaseMixin):
    is_index_handler = True
    
    @defer.inlineCallbacks
    @incrementPageView
    def get(self):
        self.render("voc_dashboard.html")


