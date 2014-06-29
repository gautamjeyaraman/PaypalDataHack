package main.java.com.tataatsu.SentimentAnalyser;

import main.java.com.tataatsu.SentimentAnalyser.health.TemplateHealthCheck;
import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Environment;
import main.java.com.tataatsu.SentimentAnalyser.resources.SentimentAnalyserResource;

import java.io.IOException;

public class SentimentAnalyserService extends Service<SentimentAnalyserServiceConfiguration> {

    public static void main(String[] args) throws Exception{
        new SentimentAnalyserService().run(args);
    }

    @Override
    public void initialize(Bootstrap<SentimentAnalyserServiceConfiguration> bootstrap){
        bootstrap.setName("Date-Parser");
    }

    @Override
    public void run(SentimentAnalyserServiceConfiguration configuration, Environment environment) throws IOException, ClassNotFoundException {
        //nothing to do yet
        environment.addHealthCheck(new TemplateHealthCheck());
        environment.addResource(new SentimentAnalyserResource());
    }
}
