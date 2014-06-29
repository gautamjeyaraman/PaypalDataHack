package main.java.com.tataatsu.SentimentAnalyser;

import com.yammer.dropwizard.config.Configuration;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.NotEmpty;

public class SentimentAnalyserServiceConfiguration extends Configuration {

    @JsonProperty
    private int port = 8083;

    public int getPort() {
        return port;
    }
}


