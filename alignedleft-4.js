// Set the parameters.
var max     = 50,
    width   = 800,
    height  = 500,
    scale   = 1000,
    padding = 50;

// Get our data.
var dataset = [];
for (var i = 0; i < max; i++) {
    dataset.push([
        Math.round(Math.random() * scale),
        Math.round(Math.random() * scale)
    ]);
}

// Create scale functions.
var xScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d[0]; })])
    .range([padding, width - padding * 2]);
var yScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d[1]; })])
    .range([height - padding, padding]);
var rScale = d3.scale.linear()
    .domain([0, d3.max(dataset, function(d) { return d[1]; })])
    .range([2, 5]);

// Define the X axis.
var xAxis = d3.svg.axis()
    .scale(xScale)
    .orient("bottom")
    .ticks(5);

// Define the Y axis.
var yAxis = d3.svg.axis()
    .scale(yScale)
    .orient("left")
    .ticks(5);

// Create SVG element.
var svg = d3.select("body")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

// Create circles.
svg.selectAll("circle")
    .data(dataset)
  .enter()
    .append("circle")
    .attr("cx", function(d) { return xScale(d[0]); })
    .attr("cy", function(d) { return yScale(d[1]); })
    .attr("r", function(d) { return rScale(d[1]); });

// Create labels.
svg.selectAll("text")
    .data(dataset)
  .enter()
    .append("text")
    .text(function(d) { return d[0] + "," + d[1]; })
    .attr("x", function(d) { return xScale(d[0]); })
    .attr("y", function(d) { return yScale(d[1]); })
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px")
    .attr("fill", "red");

// Add the X axis to the canvas.
svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(0," + (height - padding) + ")")
    .call(xAxis);

// Create Y axis.
svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(" + padding + ",0)")
    .call(yAxis);
