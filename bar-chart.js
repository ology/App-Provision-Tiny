// Self study from http://bost.ocks.org/mike/bar/2/

// Sample in-line data:
var data = [4, 8, 15, 16, 23, 42];

// Handy dimensions:
var width = data[5] * 10,
    barHeight = 40,
    text_offset = 3;

// html-chart:

// Set our range:
var range = d3.scale.linear()
  .domain([0, d3.max(data)])
  .range([0, width]);

// Render the entire chart by adding div:
d3.select(".html-chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", function(d) { return range(d) + "px"; })
    .text(function(d) { return d; });

// svg-chart:

// Get a new chart:
var chart = d3.select(".svg-chart")
    .attr("width", width)
    .attr("height", barHeight * data.length);

// Add translation to the SVG g transform:
var bar = chart.selectAll("g")
    .data(data)
  .enter().append("g")
    .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

// Add a bar:
bar.append("rect")
    .attr("width", range)
    .attr("height", barHeight - 1);

// Add the bar label:
bar.append("text")
    .attr("x", function(d) { return range(d) - text_offset; })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d; });

// tsv-chart:

// Reset the range:
range = d3.scale.linear()
    .range([0, width]);

// Reset the chart:
chart = d3.select(".tsv-chart")
    .attr("width", width);

// Import the data:
d3.tsv("bar-chart.dat", type, function(error, data) {

    // Set the domain inside a callback:
    range.domain([0, d3.max(data, function(d) { return d.value; })]);

    // Set the height dimension:
    chart.attr("height", barHeight * data.length);

    // Add translation to the SVG g transform:
    bar = chart.selectAll("g")
        .data(data)
      .enter().append("g")
        .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

    // Add a bar:
    bar.append("rect")
        .attr("width", function(d) { return range(d.value); })
        .attr("height", barHeight - 1);

    // Add the bar label:
    bar.append("text")
        .attr("x", function(d) { return range(d.value) - text_offset; })
        .attr("y", barHeight / 2)
        .attr("dy", ".35em")
        .text(function(d) { return d.value; });
});

// Set the domain inside this callback.
function type(d) {
  d.value = +d.value; // coerce to number
  return d;
}

// Horizontal bar chart:

// Reset our dimensions:
var margin = {top: 20, right: 30, bottom: 30, left: 40};
width      = 960 - margin.left - margin.right;
barHeight  = 500 - margin.top - margin.bottom;

// Set the range bands:
var bands = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

// Reset the range:
range = d3.scale.linear()
    .range([barHeight, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

// Reset the chart object:
chart = d3.select(".horiz-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", barHeight + margin.top + margin.bottom);

// Add the axis to the chart:
chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

// Load external data:
d3.tsv("bar-chart.dat", type, function(error, data) {

  // Set the domains, now that we have data:
  bands.domain(data.map(function(d) { return d.name; }));
  range.domain([0, d3.max(data, function(d) { return d.value; })]);

  // Add a 2nd axis:
  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + barHeight + ")")
      .call(xAxis);
  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis);

  // Reset the bar object:
  chart.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.name); })
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand());

});
