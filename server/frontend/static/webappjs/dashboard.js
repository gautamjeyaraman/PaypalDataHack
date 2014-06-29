var utils = {
    
    filter: {},
    
    init_filter: {}
};



$("#donutchart").html("");
$("#donutchart").html("");
var rows = _.pairs(data);
var renderData = [];
for(var i=0; i<rows.length; i++){
    renderData.push({'label': rows[i][0],
                     'data': rows[i][1]
                    });
}

$.plot($("#donutchart"), renderData, {
	series: {
			pie: {
					innerRadius: 0.5,
					show: true
			}
	},
	legend: {
		show: false
	},
	colors: ["#FA5833", "#2FABE9"]
});
	



function renderGraph(data, targetId){
    targetDiv = $("#" + targetId);
    targetDiv.html("");

    var width = targetDiv.width(),
        height = targetDiv.height(),
        padding = 1.5,
        maxRadius = 12;

    var nodes = normalize(data);
    
    // Use the pack layout to initialize node positions.
    d3.layout.pack()
        .sort(null)
        .size([width, height])
        .children(function(d) { return d.values; })
        .value(function(d) { return d.radius * d.radius; })
        .nodes(nodes);

    var force = d3.layout.force()
        .nodes(nodes)
        .size([width, height])
        .gravity(.02)
        .charge(0)
        .on("tick", tick)
        .start();

    var svg = d3.select("#" + targetId).append("svg")
        .attr("width", width)
        .attr("height", height);

    var node = svg.selectAll("a")
        .data(nodes)
      .enter()
        .append("a")
        .attr("data-feature", function(d){ return d.name;})
        .call(force.drag);
    
    var negativeG = node.append("g")
                       .attr("class", "negG");

    negativeG.append("circle")
        .attr("r", function(d){ return d.radius; })
        .style("fill", function(d) { return "#F2DEDE"; });

    var positiveG = node.append("g")
                       .attr("class", "posG");

    positiveG.append("clipPath")
        .attr('id', function(d) { return "clip" + d.index })
        .append('rect')
        .attr("x", function(d, i){ return -d.radius;})
        .attr("width", function(d, i){ return 2 * d.radius * d.sentiment / 100;})
        .attr("y", function(d, i) {return -d.radius;})
        .attr("height", function(d) {return 2  * d.radius;});

    positiveG.append("circle")
        .attr("r", function(d){ return d.radius; })
        .attr("clip-path", function(d){ return "url(#clip" + d.index + ")"; } )
        .style("fill", function(d) { return "#E4F5DC"; });

    var textNode = node.append("g")
                       .attr("class", "textNodes");
    
    textNode.append("text")
        .text(function(d) { return d.name; })
        .attr("dy", "0.3em")
        .attr("class", "labelName")
        .style("text-anchor", "middle")
        .style("font-size", function(d){ return d.fontSize.toString() + "px"; });
    
    var minFont = 18;
    
    textNode.append("text")
        .text(function(d) { return d.count; })
        .attr("dy", function(d){ var dp = (d.radius/2); return dp > minFont?dp.toString()+"px": minFont.toString() + "px"; })
        .attr("class", "labelVal")
        .style("text-anchor", "middle");

    node.transition()
        .duration(750)
        .delay(function(d, i) { return i * 5; });

    function tick(e) {
      node.selectAll("circle")
          .each(collide(.5));
      
      node.attr("transform", function(d) { 
            d.x = Math.max(d.radius, Math.min(width - d.radius, d.x));
            d.y = Math.max(d.radius, Math.min(height - d.radius, d.y));
            return "translate(" + d.x + "," + d.y + ")";
      });
    }

    // Resolves collisions between d and all other circles.
    function collide(alpha) {
      var quadtree = d3.geom.quadtree(nodes);
      return function(d) {
        var r = d.radius + maxRadius + padding,
            nx1 = d.x - r,
            nx2 = d.x + r,
            ny1 = d.y - r,
            ny2 = d.y + r;
        quadtree.visit(function(quad, x1, y1, x2, y2) {
          if (quad.point && (quad.point !== d)) {
            var x = d.x - quad.point.x,
                y = d.y - quad.point.y,
                l = Math.sqrt(x * x + y * y),
                r = d.radius + quad.point.radius + padding;
            if (l < r) {
              l = (l - r) / l * alpha;
              d.x -= x *= l;
              d.y -= y *= l;
              quad.point.x += x;
              quad.point.y += y;
            }
          }
          return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
        });
      };
    }
    
    //Method to normalize the data
    function normalize(data){
        var range = [25, 75];
        var fontRange = [14, 40];
        
        var minR = _.min(data, function(d){return d.count});
        minR = minR.count;
        
        var maxR = _.max(data, function(d){return d.count});
        maxR = maxR.count;
        
        data = data.map(function(d){
            d.radius = (d.count - minR) / maxR;
            d.fontSize = (d.radius * (fontRange[1] - fontRange[0])) + fontRange[0];
            d.radius = (d.radius * (range[1] - range[0])) + range[0];
            return d;
        });
        
        return data;
    }
}
