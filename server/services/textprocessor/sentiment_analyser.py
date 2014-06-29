import json

from twisted.internet import defer

import sentimentClassifier
from cyclone import httpclient
import requests


def infer_sentiment_maxent(text):
	classifier = "maxent"
	maxent_classifier = sentimentClassifier.SentimentClassifier(classifier)
	return maxent_classifier.infer_sentiment(text)

def infer_sentiment_naivebayes(text):
	classifier = "naivebayes"
	naivebayes_classifier = sentimentClassifier.SentimentClassifier(classifier)
	return naivebayes_classifier.infer_sentiment(text)

def infer_sentiment_lingpipe(text):
    url = "http://localhost:8080/analyse_sentiment"
    params = {"text":text}
    res = requests.post(url, data=json.dumps(params), headers={'Content-Type': 'application/json'})
    return res.json()

def infer_sentiment(text):
	#Get average of all values
	r1 = infer_sentiment_maxent(text)
	r2 = infer_sentiment_naivebayes(text)
	r3 = infer_sentiment_lingpipe(text)
	res = int((x[0]+x[1])/2)
	return res
