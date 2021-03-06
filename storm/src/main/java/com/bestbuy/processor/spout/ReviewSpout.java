package com.bestbuy.processor.spout;

import backtype.storm.spout.SpoutOutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichSpout;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Values;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.FileReader;
import java.util.List;
import java.util.Map;
import java.util.Set;


/**
 * Created by gautam
 */


public class ReviewSpout extends BaseRichSpout {

    private SpoutOutputCollector _collector;
    private Map conf;
    private String path;
    private JSONObject field_mapping;

    @Override
    public void open(Map conf, TopologyContext context, SpoutOutputCollector collector) {
        this._collector = collector;
        this.conf = conf;
        this.path = "data/reviews/";
        JSONParser parser = new JSONParser();
        String conf_path = path + "config.json";
        field_mapping = new JSONObject();
        try{
            field_mapping = (JSONObject) parser.parse(new FileReader(conf_path));
        }
        catch (Exception e){
            System.out.println("ERROR");
        }

    }

    @Override
    public void nextTuple(){

        Set<String> keys = field_mapping.keySet();
        for(String key : keys){
            List<String> values= (List)field_mapping.get(key);
            for(String value : values){
                String currentPath = path + key + "/" + value;
                JSONArray reviews = new JSONArray();
                JSONParser parser = new JSONParser();
                try{
                    reviews = (JSONArray) parser.parse(new FileReader(currentPath));
                }
                catch (Exception e){
                    System.out.println("ERROR");
                }
                for(Object review : reviews){
                    JSONObject reviewJson = (JSONObject)review;
                    String text = (String)reviewJson.get("description");
                    int rating = Integer.parseInt((String)reviewJson.get("star"));
                    String date = (String)reviewJson.get("date");
                    String prod = value.split("\\.")[0];
                    _collector.emit(new Values(text, key, prod, date, rating));
                }
            }
        }

    }

    @Override
    public void ack(Object id) {
    }


    @Override
    public void declareOutputFields(OutputFieldsDeclarer declarer) {
        declarer.declare(new Fields("text", "type", "product", "date", "rating"));
    }

}
