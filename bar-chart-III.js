// Self study from http://bost.ocks.org/mike/bar/2/

// Horizontal bar chart

// Set the domain inside this callback.
function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}

// Reset our dimensions
var margin = {top: 20, right: 30, bottom: 30, left: 40},
    width      = 960 - margin.left - margin.right,
    barHeight  = 500 - margin.top - margin.bottom;

// Set the range bands
var bands = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

// Reset the range
range = d3.scale.linear()
    .range([barHeight, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

// Reset the chart object
chart = d3.select(".horiz-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", barHeight + margin.top + margin.bottom);

// Add the axis to the chart
chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

// Load external data
d3.tsv("bar-chart.dat", type, function(error, data) {

  // Set the domains, now that we have data
  bands.domain(data.map(function(d) { return d.name; }));
  range.domain([0, d3.max(data, function(d) { return d.value; })]);

  // Add a 2nd axis
  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + barHeight + ")")
      .call(xAxis);
  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis);

  // Reset the bar object
  chart.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.name); })
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand());

});
