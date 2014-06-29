import re
from cyclone_server.db.postgres import PostgresDatabase
from twisted.internet import defer
from cyclone_server import utils
from cyclone_server.utils import BaseHandler, incrementPageView
from cyclone_server.db.mixin import DatabaseMixin

class IndexHandler(BaseHandler, DatabaseMixin):
    is_index_handler = True
    
    @defer.inlineCallbacks
    def get(self):
        db = PostgresDatabase(self)
        Merchant_lists = yield self.database.get_list_of_merchant()
        self.render("voc_dashboard.html", Merchant_lists = Merchant_lists)

class MerchentDashBoarHandler(BaseHandler, DatabaseMixin):
    is_MerchentDashBoarHandler = True
           
    @defer.inlineCallbacks
    def Merchant_page(self, merchant_id):
        db = PostgresDatabase(self)
        female_customer = yield self.database.get_female_customer_for_merchant(merchant_id)
        male_customer = yield self.database.get_male_customer_for_merchant(merchant_id)
        self.render("merchant_page.html", female_customer = female_customer, male_customer = male_customer)
        
        


