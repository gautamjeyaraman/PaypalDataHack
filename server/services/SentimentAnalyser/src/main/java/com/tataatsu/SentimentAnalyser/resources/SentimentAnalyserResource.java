package main.java.com.tataatsu.SentimentAnalyser.resources;

import main.java.com.tataatsu.SentimentAnalyser.core.SentimentAnalyserCore;
import main.java.com.tataatsu.SentimentAnalyser.core.TextObject;
import com.yammer.metrics.annotation.Timed;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.util.*;

@Path("/analyse_sentiment")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SentimentAnalyserResource {
    SentimentAnalyserCore sa ;

    public SentimentAnalyserResource() throws IOException, ClassNotFoundException {
        sa = new SentimentAnalyserCore();
    }

    @POST
    @Timed
    public Map<String, String> analyseSentiment(TextObject text) throws IOException, ClassNotFoundException {
        System.out.println(text.getText());
        String response =  sa.resolveTextSentiment(text.getText());
        System.out.println(response);
        HashMap<String ,String> resp = new HashMap<String, String>();
        resp.put("result", response);
        return resp;
    }
}