// Set canvas dimensions.
var max         = 20,
    yScale      = 30,
    hScale      = 5,
    width       = 700,
    height      = 200,
    barPadding  = 1;

// Get our data.
var dataset = [];
for (var i = 0; i < max; i++) {
    var newNumber = Math.round(Math.random() * yScale) + hScale;
    dataset.push(newNumber);
}

// Make an SVG canvas.
var svg = d3.select("body")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

// Make bars.
var bars = svg.selectAll("rect")
    .data(dataset)
  .enter()
    .append("rect");

// Position & style the bars.
bars
    // Bar width is a fraction of the canvas width.
    .attr("x", function(d, i) { return i * (width / dataset.length); })
    // Height minus data value.
    .attr("y", function(d) { return height - (d * hScale); })
    // Bar width is a fraction of the canvas width.
    .attr("width", width / dataset.length - barPadding)
    .attr("height", function(d) { return d * hScale; })
    .attr("fill", function(d) { return "rgb(0, 0, " + (d * 10) + ")"; });;

var labels = svg.selectAll("text")
    .data(dataset)
  .enter()
    .append("text");

labels
    .text(function(d) { return d; })
    .attr("text-anchor", "middle")
    .attr("x", function(d, i) {
        return i * (width / dataset.length) + (width / dataset.length - barPadding) / 2;
    })
    .attr("y", function(d) { return height - (d * hScale) + 14; })
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px")
    .attr("fill", "white");

