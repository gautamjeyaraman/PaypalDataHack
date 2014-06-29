package com.bestbuy.processor.topology;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.StormSubmitter;
import backtype.storm.generated.StormTopology;
import backtype.storm.topology.TopologyBuilder;

import com.bestbuy.processor.bolt.*;
import com.bestbuy.processor.spout.TwitterSpout;

public class ProcessorTopology {

    public static StormTopology build() {
        TopologyBuilder builder = new TopologyBuilder();

        builder.setSpout("twitterspout", new TwitterSpout());
        builder.setBolt("indexreview", new SampleReviewBolt(), 1).shuffleGrouping("twitterspout");

        return builder.createTopology();
    }

    public static void main(String[] args) throws Exception {
        //ProcessorTopology builder = new ProcessorTopology();
        StormTopology topology =  ProcessorTopology.build();

        Config conf = new Config();
        conf.put(Config.TOPOLOGY_DEBUG, false);
        conf.setDebug(false);


        if (args != null && args.length > 0) {
            conf.setNumWorkers(1);

            StormSubmitter.submitTopology(args[0], conf, topology);
        }
        else {
            //run locally
            conf.setMaxTaskParallelism(2);

            LocalCluster cluster = new LocalCluster();
            cluster.submitTopology("parser", conf, topology);

            Thread.sleep(18000000);//30 mins

            cluster.shutdown();
        }
    }
}
