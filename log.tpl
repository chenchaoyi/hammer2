<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawRespChart);
    google.setOnLoadCallback(drawAvgChart);
    
    if (!Array.prototype.filter){
	  Array.prototype.filter = function(fun /*, thisp*/){
	    var len = this.length;
	    if (typeof fun != "function")
	      throw new TypeError();

	    var res = new Array();
	    var thisp = arguments[1];
	    for (var i = 0; i < len; i++) {
	      if (i in this){
	        var val = this[i]; // in case fun mutates this
	        fun.call(thisp, val, i, this)
	        res.push(val);
	      }
	    }

	    return res;
	  };
	}

    var allData = eval({{.Data}})
    var allData2 = eval({{.Data}})

    function countFilter(element, index, array){
    	return element.splice(6, 1)
    }

    function avgFilter(element, index, array){
    	element[6] /= 1000 
    	return element.splice(1, 5)
    }

    function drawRespChart() {
    	var arr = allData.filter(countFilter)
	    var data = google.visualization.arrayToDataTable(arr);

	    var options = {
	        title: {{.Title}}
	    };

	    var chart = new google.visualization.LineChart(document.getElementById('resp_div'));
	    chart.draw(data, options);
    }

    function drawAvgChart() {
    	var arr = allData2.filter(avgFilter)
	    var data = google.visualization.arrayToDataTable(arr);

	    var options = {
	        title: "Average Response Time [ms]"
	    };

	    var chart = new google.visualization.LineChart(document.getElementById('avg_div'));
	    chart.draw(data, options);
    }
 	setTimeout(function(){
 	  	window.location.reload(1);
	}, 10000);
</script>
<div id="resp_div" style="width: 600px; height: 350px;float:left;"></div>
<div id="avg_div" style="width: 600px; height: 350px;float:left;"></div>