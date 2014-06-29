import sys
import logging
import logging.config

logging.config.fileConfig("logging.conf")
logger = logging.getLogger("textprocessor")

sys.path.append("./gen-py")

from textprocessor import TextProcessor
from textprocessor.ttypes import *
from textprocessor.constants import *
from textprocessor import ttypes


from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

from mx.DateTime import *
from mx import DateTime
import kaala

try:
    # k = kaala.Kaala()
    # print(k.resolve_expression("What day is it today?",DateTime.localtime().strftime() ))
    transport = TSocket.TSocket('localhost', 3001)
    transport = TTransport.TBufferedTransport(transport)

    protocol = TBinaryProtocol.TBinaryProtocol(transport)

    client = TextProcessor.Client(protocol)

    transport.open()
    logger.info("Opened client transport..")

    sentences = ["Who is it?", "Are you done?", "Is it on?", "Will you confirm?", "Really??!", "Did you receive invoice?", "I got the mail"]

    for sent in sentences:
        retVal = client.infer_dialogtype("123", sent)
        #print "sent:", sent, "***", retVal

    print "Doing time stuff..."
    sentences = ["What day is it today?", "I shall know in ten days", "Invoice is due in 10 days", "Let us meet in two days", "Call me in two months", "Did we receive payment yesterday?"]

    for sent in sentences:
        dt = ttypes.DateTime(2013, 6, 22, 0, 0)
        retVal = client.parse_time_expression(sent, dt)
        print "final result:", retVal

    transport.close()

except Thrift.TException, tx:
    logging.exception(tx)

except Exception, e:
    print e
    logging.exception(e)
