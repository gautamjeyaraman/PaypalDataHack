package main.java.com.tataatsu.SentimentAnalyser.core;

import com.aliasi.classify.LMClassifier;
import com.aliasi.util.Files;
import com.aliasi.classify.Classification;
import com.aliasi.classify.Classified;
import com.aliasi.classify.DynamicLMClassifier;
import com.aliasi.sentences.SentenceChunker;
import com.aliasi.sentences.MedlineSentenceModel;
import com.aliasi.sentences.SentenceModel;
import com.aliasi.tokenizer.IndoEuropeanTokenizerFactory;
import com.aliasi.tokenizer.TokenizerFactory;
import com.aliasi.lm.NGramProcessLM;
import java.io.*;
import java.lang.System;
import java.io.IOException;


public class SentimentAnalyserCore{

    private TokenizerFactory TOKENIZER_FACTORY = IndoEuropeanTokenizerFactory.INSTANCE;
    private SentenceModel SENTENCE_MODEL  = new MedlineSentenceModel();
    private SentenceChunker SENTENCE_CHUNKER = new SentenceChunker(TOKENIZER_FACTORY,SENTENCE_MODEL);


    File mPolarityDir;
    String[] mCategories;
    DynamicLMClassifier<NGramProcessLM> mClassifier;
    LMClassifier lmClassifier;

    public SentimentAnalyserCore() throws IOException, ClassNotFoundException {

        mPolarityDir = new File(System.getProperty("user.dir") + "/Resources/Twitter_neg_pos" ,"txt_sentoken");
        System.out.println("\nData Directory=" + mPolarityDir);
        mCategories = mPolarityDir.list();
        System.out.println(mCategories.toString());
        int nGram = 8;
        //mclassifier instance is not used when there is a trained model available.
        mClassifier
                = DynamicLMClassifier
                .createNGramProcess(mCategories,nGram);

        //Load model if already there else train and write model to file
        FileInputStream LMClassifierStream = null;
        LMClassifierStream = new FileInputStream(System.getProperty("user.dir") + "/Resources/Trained_classifier/LMSentimentClassifier");
        BufferedInputStream bufIn = null;
        ObjectInputStream objIn = null;
        bufIn = new BufferedInputStream(LMClassifierStream);
        objIn = new ObjectInputStream(bufIn);
        //mClassifier = (DynamicLMClassifier) read(objIn);
        lmClassifier = (LMClassifier) objIn.readObject();
        if(LMClassifierStream == null)
        {System.out.println("NO MODEL FOUND, TRAINING STARTED...");  train();}
        //evaluate();
    }

    boolean isTrainingFile(File file) {
        return file.getName().charAt(2) != '9';  // test on fold 9
    }

    void train() throws IOException {
        int numTrainingCases = 0;
        int numTrainingChars = 0;
        System.out.println("\nTraining.");
        System.out.println("CATEGORIES : " + mCategories.length);
        for (int i = 1; i < mCategories.length; ++i) {
            System.out.println(mCategories[i]);
            String category = mCategories[i];
            Classification classification
                    = new Classification(category);
            File file = new File(mPolarityDir,mCategories[i]);
            File[] trainFiles = file.listFiles();
            for (int j = 0; j < trainFiles.length; ++j) {
                System.out.println("TRAIN FILE  : " + j);
                File trainFile = trainFiles[j];
                if (isTrainingFile(trainFile)) {
                    ++numTrainingCases;
                    String review = Files.readFromFile(trainFile,"ISO-8859-1");
                    numTrainingChars += review.length();
                    Classified<CharSequence> classified
                            = new Classified<CharSequence>(review,classification);
                    mClassifier.handle(classified);
                }
            }
        }
        FileOutputStream objstr = new FileOutputStream(System.getProperty("user.dir") + "/Resources/Trained_classifier/LMSentimentClassifier");
        ObjectOutputStream objout = new ObjectOutputStream(objstr);
        mClassifier.compileTo(objout);
        System.out.println("  # Training Cases=" + numTrainingCases);
        System.out.println("  # Training Chars=" + numTrainingChars);
    }


    public String resolveTextSentiment(String text) throws IOException, ClassNotFoundException {

       Classification classification
                = lmClassifier.classify(text);
       System.out.println("CLASSIFIED AS : " + classification.bestCategory());
       return (classification.bestCategory());

    }

    void evaluate() throws IOException, ClassNotFoundException {
        System.out.println("\nEvaluating.");
        int numTests = 0;
        int numCorrect = 0;
        for (int i = 1; i < mCategories.length; ++i) {
            String category = mCategories[i];
            File file = new File(mPolarityDir,mCategories[i]);
            File[] trainFiles = file.listFiles();
            System.out.println(trainFiles.length);
            for (int j = 0; j < trainFiles.length; ++j) {
                File trainFile = trainFiles[j];
                if (!isTrainingFile(trainFile)) {
                    String review = Files.readFromFile(trainFile,"ISO-8859-1");
                    ++numTests;
                    Classification classification
                            = mClassifier.classify(review);
                    if (classification.bestCategory().equals(category))
                        ++numCorrect;
                }
            }
        }
        System.out.println("  # Test Cases=" + numTests);
        System.out.println("  # Correct=" + numCorrect);
        System.out.println("  % Correct="
                + ((double)numCorrect)/(double)numTests);
    }
}


