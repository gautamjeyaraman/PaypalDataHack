var utils = {

    getCookie: function(name){
        var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
        return r ? r[1] : undefined;
    },
    
    filter: {},
    
    init_filter: {}
};


var api = {

    getView1: function(term, filter){
        var url = '/api/latest/csr/view1';
        var argJson = {}
        if(typeof term != "undefined" && term.length > 0){
            argJson.term = term;
        }
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView2: function(filter){
        var url = '/api/latest/csr/view2';
        var argJson = {}
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView3: function(filter){
        var url = '/api/latest/csr/view3';
        var argJson = {}
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView4: function(filter){
        var url = '/api/latest/csr/view4';
        var argJson = {}
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView5: function(term, filter){
        var url = '/api/latest/csr/view5';
        var argJson = {}
        if(typeof term != "undefined" && term.length > 0){
            argJson.term = term;
        }
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView6: function(term, filter){
        var url = '/api/latest/csr/view6';
        var argJson = {}
        if(typeof term != "undefined" && term.length > 0){
            argJson.term = term;
        }
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView7: function(type, filter){
        var url = '/api/latest/csr/view7';
        var argJson = {}
        if(typeof type != "undefined" && type.length > 0){
            argJson.order = type;
        }
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },
    
    getView8: function(){
        var url = '/api/latest/csr/view8';
        var params = {'_xsrf': utils.getCookie("_xsrf")};
	    return $.get(url, params).then(function(res){
	        return res;
        });
    },

    getView9: function(filter){
        var url = '/api/latest/csr/view9';
        var argJson = {}
        if(typeof filter != "undefined"){
            argJson.filter = filter;
        }
        var params = {'_xsrf': utils.getCookie("_xsrf"), "argJson": JSON.stringify(argJson)};
	    return $.post(url, params).then(function(res){
	        return res;
        });
    },

    getView10: function(term, guid, limit){
        var url = '/api/latest/csr/view10';
        var params = {'_xsrf': utils.getCookie("_xsrf")};
        if(typeof term != "undefined"){
            params["q"] = term;
        }
        if(typeof guid != "undefined"){
            params["guid"] = guid;
        }
        if(typeof limit != "undefined"){
            params["limit"] = limit;
        }
        else{
            params["limit"] = 1;
        }
	    return $.get(url, params).then(function(res){
	        return res;
        });
    },
}


function renderView1(term, filter){
    var viewDiv1 = $("#viewDiv1");
    viewDiv1.html("");
    if(typeof term == "undefined"){
        term = "";
    }
    api.getView1(term, filter).then(function(rows){
        var viewTmpl1 = _.template($("#viewItem1").html());
        for(var i=0; i<rows.length; i++){
            rows[i].className = (i%2==0)?'even':'odd';
            var sentiScore = rows[i].Sentiment;
            rows[i].sentiClass = (sentiScore > 60)? "label-success": (sentiScore < 40)? "label-important": "label-warning";
            rows[i].starRating = Math.floor(rows[i].Rating*5);
            viewDiv1.append(viewTmpl1 (rows[i]));
        }
    });
}


function renderView2(filter){
    $("#donutchart").html("");
    api.getView2(filter).then(function(data){
        $("#donutchart").html("");
        var rows = _.pairs(data);
        var renderData = [];
        var totalRevs = 0;
        for(var i=0; i<rows.length; i++){
            renderData.push({'label': rows[i][0],
                             'data': rows[i][1]
                            });
            totalRevs += rows[i][1];
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
		
		$("#total-revs").html(totalRevs);
        
    });
}


function renderView3(filter){
    var viewDiv3 = $("#viewDiv3");
    viewDiv3.html("");
    api.getView3(filter).then(function(data){
        var viewTmpl3 = _.template($("#viewItem3").html());
        viewDiv3.html("");
        for(var i=0; i<data.length; i++){
            for(var j=0; j<data[i].row.length; j++){
                var sentiVal = data[i].row[j].sentiment;
                data[i].row[j].sentiClass = (sentiVal > 60)? "label-success": (sentiVal < 40)? "label-important": "label-warning";
            }
            viewDiv3.append(viewTmpl3(data[i]));
        }
    });
}


function renderView4(filter){
    var viewDiv4 = $("#viewDiv4");
    viewDiv4.html("");
    api.getView4(filter).then(function(data){
        var viewTmpl4 = _.template($("#viewItem4").html());
        viewDiv4.html("");
        for(var i=0; i<data.length; i++){
            data[i].className = (i%2==0)?'even':'odd';
            viewDiv4.append(viewTmpl4 (data[i]));
        }
    });
}


function renderView5(term, filter){
    $("#viewChart5").html("");
    api.getView5(term, filter).then(function(data){
      var rows = _.pairs(data);
      var renderRows = [];
      $("#viewChart5").html("");
      for(var i=0; i<rows.length; i++){
          renderRows.push({'x': rows[i][0],
                           'y': rows[i][1]});
      }
      var renderData = {
          "xScale": "ordinal",
          "yScale": "linear",
          "main": [{"data": renderRows}]
      };
      var barChart = new xChart('bar', renderData, '#viewChart5');
    });
}


function renderView6(term, filter){
    var viewDiv6 = $("#viewDiv6");
    viewDiv6.html("");
    api.getView6(term, filter).then(function(data){
        var viewTmpl6 = _.template($("#viewItem6").html());
        viewDiv6.html("");
        var maxOc = 0;
        _.each(data, function(d){ if (d.count > maxOc){ maxOc = d.count; }});
        for(var i=0; i<data.length; i++){
            data[i].occPer = (data[i].count / maxOc) * 100;
            viewDiv6.append(viewTmpl6(data[i]));
        }
    });
}


function renderView7(filter){
    
    $("#viewDiv7-top").html("");
    api.getView7("top", filter).then(function(data){
        var viewTmpl7 = _.template($("#viewItem7").html());
        var viewDiv7 = $("#viewDiv7-top");
        viewDiv7.html("");
        data = _.sortBy(data, function(item){ return -item.Rating;});
        for(var i=0; i<data.length; i++){
            data[i].className = (i%2 != 0)?"alt":"";
            data[i].type = "positive";
            viewDiv7.append(viewTmpl7(data[i]));
        }
    });

    $("#viewDiv7-bottom").html("");
    api.getView7("bottom", filter).then(function(data){
        var viewTmpl7 = _.template($("#viewItem7").html());
        var viewDiv7 = $("#viewDiv7-bottom");
        viewDiv7.html("");
        data = _.sortBy(data, function(item){ return item.Rating;});
        for(var i=0; i<data.length; i++){
            data[i].className = (i%2 != 0)?"alt":"";
            data[i].type = "negative";
            viewDiv7.append(viewTmpl7(data[i]));
        }
    });
}


function renderView8(){
    var viewDiv8 = $("#viewDiv8");
    viewDiv8.html("");
    api.getView8().then(function(data){
        var viewTmpl8 = _.template($("#viewItem8").html());
        viewDiv8.html("");
        for(var i=0; i<data.length; i++){
            data[i].className = (i%2==0)?'even':'odd';
            viewDiv8.append(viewTmpl8 (data[i]));
        }
    });
}


function renderView9(filter){
    $("#viewDiv9").html("");
    api.getView9(filter).then(function(data){
        renderGraph1(data, "viewDiv9");
        $("a[data-feature]").click(function(){
            renderView1($(this).data("feature"), utils.filter);
        });
    });
}


function renderAllViews(term, filter){
    renderView1(term, filter);
    renderView2(filter);
    renderView3(filter);
    renderView4(filter);
    renderView5(term, filter);
    renderView6(term, filter);
    renderView7(filter);
    renderView8();
    renderView9(filter);
}

function getStringFromTS(ts){
    return moment.unix(ts).format("Do MMM YYYY");
}

function updateDateRangeUI(){
    var dtRange = (typeof utils.filter.crdate == "undefined")?utils.init_filter.crdate: utils.filter.crdate;
    $("#timeRangeVal > .from").html(getStringFromTS(dtRange["min"]));
    $("#timeRangeVal > .to").html(getStringFromTS(dtRange["max"]));
}

function initiateFilterWidgets(){
    //For filter autocomplete
    $("#locationTags").tagit({
        fieldName: "locationFilter",
        showAutocompleteOnFocus: true,
        caseSensitive: false,
        placeholderText: "Select Location ...",
        availableTags: utils.init_filter.location
    });
    
    updateDateRangeUI();
    
    $("#timeRange").slider({
		range: true,
		min: utils.init_filter.crdate['min'],
		max: utils.init_filter.crdate['max'],
		values: [ utils.init_filter.crdate['min'], utils.init_filter.crdate['max'] ],
		slide: function( event, ui ) {
		    utils.filter.crdate = {"min": ui.values[0],
		                           "max": ui.values[1]};
		    updateDateRangeUI();
		}
	});
}

function initiateWidgetEvents(){
    //Events
    $("#refreshView1").click(function(){
        renderView1(undefined, utils.filter);
    });
    
    $("span[data-feature]").live("click", function(){
        $("span[data-feature]").popover('destroy');

        var currentElement = $(this);
        var feature = currentElement.data("feature");
        var rguid = currentElement.data("review");
        var sterm = currentElement.data("sterm");
        sterm = (typeof sterm == "undefined")?feature:sterm;

        var htmlContent = "<div class='tip10' id='tip10'><img src='/static/icons/loading.gif' class='iconLoading'/></div><a href='/dashboard/reviews?q=" + feature + "' class='btn btn-primary btn-xs polink' target='_new'>View more on <i style='font-weight:800;'>" + feature + "</i></a>";

        var popOverOptions = {
                            'html': true,
                            'placement': 'auto',
                            'trigger': 'manual',
                            'title': "Reviews<button type='button' class='close' id='poclose'>×</button>",
                            'content': htmlContent
                         };
        currentElement.popover(popOverOptions);
        currentElement.popover("show");
        $(".box-content").attr("style", "z-index:50;");
        $(".box-content").has(currentElement).attr("style", "z-index:1000;");
        
        var viewTmpl10 = _.template($("#viewItem10").html());

        var dataDeferred = api.getView10(feature, rguid);
        
        window.setTimeout(function(){
            dataDeferred.then(function(res){
                if(res.success && res.data.length > 0){
                    var data = res.data[0];
                    data.frdate = moment.unix(data.crdate).format("DD, MMM YYYY");
                    data.starRating = Math.floor(data.rating*5);
                    data.htmlcontent = _.escape(data.content);
                    data.htmlcontent = data.htmlcontent.replace(new RegExp(sterm, 'ig'), "<em>" + sterm + "</em>");
                    $("#tip10").html(viewTmpl10(data));
                }
            });

            $("#poclose").click(function(){
                currentElement.popover("destroy");
            });
        }, 200);
    });
    
    $(".ratingBtn").click(function(){
        $(this).toggleClass("btn-success")
               .find("i").toggleClass("fa-circle")
                         .toggleClass("fa-check-circle");
    });
    
    $("#toggle-filter-btn").click(function(){
        $(".filter-div").slideToggle();
        $(this).find(".show-filter").toggle();
        $(this).find(".hide-filter").toggle();
    });
    
    $("#filter-btn").click(function(){
        var filter = {};

        if( typeof utils.filter.crdate != "undefined" && !(_.isEqual(utils.filter.crdate, utils.init_filter.crdate)) ){
            filter.crdate = utils.filter.crdate;
        }

        var rating_array = [];
        $(".ratingBtn").each(function(index, element){
            if($(element).hasClass("btn-success")){
                rating_array.push($(element).data("rating"));
            }
        });
        if(rating_array.length > 0 && _.difference(utils.init_filter.rating, rating_array).length != 0){
            filter.rating = rating_array;
        }
        
        var location_array = $("#locationTags").tagit("assignedTags");
        if(location_array.length > 0 && _.difference(utils.init_filter.location, location_array).length != 0){
            filter.location = location_array;
        }

        //To have the filter for further term query
        utils.filter = filter;
        
        updateStatsHeader()
        
        renderAllViews(undefined, filter);
    });

}

function updateStatsHeader(){
    var dtRange = (typeof utils.filter.crdate == "undefined")?utils.init_filter.crdate: utils.filter.crdate;
    $("#stats-crdate").html(getStringFromTS(dtRange["min"]) + " - " + getStringFromTS(dtRange["max"]));
    
    if(typeof utils.filter.location == "undefined"){
        $("#stats-loc").html("All");
        $("#stats-loc").attr("title", "");
        $("#stats-loc-lbl").html("Locations");
    }
    else{
        $("#stats-loc").html(utils.filter.location.length);
        $("#stats-loc").attr("title", utils.filter.location.join(", "));
        if(utils.filter.location.length == 1){
            $("#stats-loc-lbl").html("Location");
        }
        else{
            $("#stats-loc-lbl").html("Locations");
        }
    }

    if(typeof utils.filter.rating == "undefined"){
        $("#stats-rat").html("Any");
    }
    else{
        $("#stats-rat").html(utils.filter.rating.join(", "));
    }
}


$(document).ready(function() {
    renderAllViews();
    initiateFilterWidgets();
    initiateWidgetEvents();
    updateStatsHeader();
});


function renderGraph1(data, targetId){
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
