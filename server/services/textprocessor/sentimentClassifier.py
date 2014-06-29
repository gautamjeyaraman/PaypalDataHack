import nltk
import os
import cPickle
import nltk.classify.util
from nltk.classify import NaiveBayesClassifier, MaxentClassifier
from nltk.tokenize import RegexpTokenizer
import nltk.data
from nltk.corpus.reader import CategorizedPlaintextCorpusReader
from nltk.corpus import movie_reviews
import argparse
from nltk.corpus import stopwords
from replacers import RepeatReplacer, AntonymReplacer

ant_replacer = AntonymReplacer()
rep_replacer = RepeatReplacer()
english_stops = set(stopwords.words('english'))

curdir = os.path.abspath(os.curdir)
classifier_path = os.path.join(curdir, "classifiers", "nb_new_senti")

#logger = logging.getLogger("textprocessor.sentimentClassifier") 
tokenizer = RegexpTokenizer("[\w']+")

def refine_words(words):
    #words = [word for word in words if word not in english_stops]
    words = [rep_replacer.replace(word) for word in words]
    return ant_replacer.replace_negations(words)


def word_feats(words):
    words = refine_words(words)
    return dict([(word, True) for word in words])
 
class SentimentClassifier():
    def __init__(self, clsf="naivebayes"):
        try:
            classifier = None
            if not os.path.exists(classifier_path):

                with open('nltk_sentiment_data/sentiment_data_twitter.txt', 'rb') as fp:                 
                    lines = fp.readlines()
                    feats =[(word_feats(tokenizer.tokenize(line.split(' -> ')[1].strip().lower())), line.split(' -> ')[0]) for line in lines if len(line.split(' -> ')) >=2]
                print "Total : %s" %(len(feats),)
                cutoff = int(len(feats)*0.1)
                trainfeats, testfeats = feats[cutoff:], feats[:cutoff]

                print 'train on %d instances, test on %d instances' % (len(trainfeats), len(testfeats))

                if clsf is "naivebayes":
                    classifier = NaiveBayesClassifier.train(trainfeats)
                elif clsf is "maxent":
                    classifier = MaxentClassifier.train(trainfeats, algorithm='iis', trace=0, max_iter=10)

                print 'accuracy:', nltk.classify.util.accuracy(classifier, testfeats)
                classifier.show_most_informative_features()
                with open(classifier_path, "w") as fh:
                    cPickle.dump(classifier, fh, 1)
            else:
                with open(classifier_path, "r") as fh:
                    classifier = cPickle.load(fh)
            self.classifier = classifier
        except Exception, e:
            raise e
    
    def infer_sentiment(self, text):
        try:
            machine_guess = self.classifier.prob_classify(word_feats(tokenizer.tokenize(text.lower())))
            return int(machine_guess.prob('1') * 100)
        except Exception, e:
            raise e 
