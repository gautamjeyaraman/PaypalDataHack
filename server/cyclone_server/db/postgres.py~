from twisted.internet import defer
import query
from datetime import datetime
import psycopg2



class PostgresDatabase(object):
    def __init__(self, connection, cache=None):
        self.connection = connection
        self.cache = cache

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

                
    

