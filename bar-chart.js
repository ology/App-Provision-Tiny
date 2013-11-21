// Self study from http://bost.ocks.org/mike/bar/2/

// Sample in-line data:
var data = [4, 8, 15, 16, 23, 42];

// html-chart:
var x = d3.scale.linear()
  .domain([0, d3.max(data)])
  .range([0, 420]);

// Render the entire chart by adding div:
d3.select(".html-chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", function(d) { return x(d) + "px"; })
    .text(function(d) { return d; });

// svg-chart:

var width = 420,
    barHeight = 20,
    text_offset = 3;

// Set our range:
var y = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, width]);

// Get a new chart:
var chart = d3.select(".svg-chart")
    .attr("width", width)
    .attr("height", barHeight * data.length);

var bar = chart.selectAll("g")
    .data(data)
  .enter().append("g")
    .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

bar.append("rect")
    .attr("width", y)
    .attr("height", barHeight - 1);

bar.append("text")
    .attr("x", function(d) { return y(d) - text_offset; })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d; });

// tsv-chart:

// Set our range:
var z = d3.scale.linear()
    .range([0, width]);

var chart = d3.select(".tsv-chart")
    .attr("width", width);

d3.tsv("bar-chart.dat", type, function(error, data) {
  z.domain([0, d3.max(data, function(d) { return d.value; })]);

  chart.attr("height", barHeight * data.length);

  var bar = chart.selectAll("g")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

  bar.append("rect")
      .attr("width", function(d) { return z(d.value); })
      .attr("height", barHeight - 1);

  bar.append("text")
      .attr("x", function(d) { return z(d.value) - text_offset; })
      .attr("y", barHeight / 2)
      .attr("dy", ".35em")
      .text(function(d) { return d.value; });
});

// Set the domain inside a callback.
function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}
