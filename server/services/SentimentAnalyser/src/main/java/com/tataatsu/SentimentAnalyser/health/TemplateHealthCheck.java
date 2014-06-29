package main.java.com.tataatsu.SentimentAnalyser.health;

import com.yammer.metrics.core.HealthCheck;

public class TemplateHealthCheck extends HealthCheck {

    public TemplateHealthCheck(){
        super("template");

    }

    @Override
    protected Result check() throws Exception{

        return Result.healthy();
    }
}
