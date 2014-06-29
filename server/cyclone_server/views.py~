import re
from cyclone_server.db.postgres import PostgresDatabase
from twisted.internet import defer
from cyclone_server import utils
from cyclone_server.utils import BaseHandler
from cyclone_server.db.mixin import DatabaseMixin

class IndexHandler(BaseHandler, DatabaseMixin):
    is_index_handler = True
    
    @defer.inlineCallbacks
    def get(self):
        db = PostgresDatabase(self)
        Merchant_lists = self.database.get_list_of_merchant()
        self.render("dashboard.html", Merchant_lists = Merchant_lists)
        
    @defer.inlineCallbacks
    def Merchant_page(self):
        self.render("merchant_page.html")
        
        


