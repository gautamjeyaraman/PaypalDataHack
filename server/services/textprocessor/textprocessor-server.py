import sys
#import logging
#import logging.config

#logging.config.fileConfig("logging.conf")
#logger = logging.getLogger("textprocessor.server")
#logger1 = logging.getLogger("textprocessor.Kaala")

sys.path.append('./gen-py.twisted')

from textprocessor import TextProcessor
from textprocessor.ttypes import *
from textprocessor.constants import *

from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer
from zope.interface import implements
from twisted.internet import reactor
from thrift.transport import TTwisted
from sentimentClassifier import SentimentClassifier
from sentiment_analyser import *


class TextProcessorHandler:
    implements(TextProcessor.Iface)

    def __init__(self):
        
        self.sentimentClassifier = SentimentClassifier()
        #logger.info("TextProcessorHandler initialized..")

    def infer_sentiment(self, DocText):
        #logger.info("Sentiment type for : " + DocText)
        retVal = infer_sentiment(DocText)
        print DocText
        print retVal
        return retVal

try:
    handler = TextProcessorHandler()
    processor = TextProcessor.Processor(handler)
    pfactory = TBinaryProtocol.TBinaryProtocolFactory()
    server = reactor.listenTCP(3001,
                TTwisted.ThriftServerFactory(processor,
                pfactory))
    reactor.run()

except Exception, e:
    logger.exception(e)
    raise e
finally:
    logger.info("Shutting down TextProcessor server.")
