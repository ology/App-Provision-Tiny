// Self study from http://bost.ocks.org/mike/bar/2/

// Horizontal bar chart

// Set the domain inside this callback.
function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}

// Set our dimensions
var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width  = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

// Set the range bands
var bands = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

// Set the range
var range = d3.scale.linear()
    .range([height, 0]);

// Get axes
var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");
var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10, "%");

// Set the chart object
var chart = d3.select(".horiz-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// Load external data
d3.tsv("bar-chart.dat", type, function(error, data) {

  // Set the domains, now that we have data
  bands.domain(data.map(function(d) { return d.name; }));
  range.domain([0, d3.max(data, function(d) { return d.value; })]);

  // Add the axis to the chart
  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);
  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Frequency");

  // Set the bar object
  chart.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.name); })
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand());

});
