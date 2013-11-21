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

// Reset the text offset:
text_offset = 13;

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
