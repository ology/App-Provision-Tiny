// Set the parameters.
var width   = 300,
    height  = 300,
    ticknum = 6,
    dot     = 8,
    padding = 50;

// Get our data.
var strings = [
    [1, 1.5],
    [2, 2.5],
    [3, 3.5],
    [4, 4.5],
    [5, 5.5],
    [6, 6.5]
];

// Create scale functions.
var xScale = d3.scale.linear()
    .domain([1, d3.max(strings, function(d) { return d[0]; })])
    .range([padding, width - padding * 2]);
var yScale = d3.scale.linear()
    .domain([1, d3.max(strings, function(d) { return d[1]; })])
    .range([height - padding, padding]);

// Define the axes.
var xAxis = d3.svg.axis()
    .scale(xScale)
    .orient("top")
    .ticks(ticknum);
var yAxis = d3.svg.axis()
    .scale(yScale)
    .orient("left")
    .ticks(ticknum);

// Create SVG canvas element.
var svg = d3.select("body")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

// Additional axes
function make_x_axis() {        
    return d3.svg.axis()
        .scale(xScale)
         .orient("bottom")
         .ticks(ticknum)
}
function make_y_axis() {        
    return d3.svg.axis()
        .scale(yScale)
        .orient("left")
        .ticks(ticknum)
}

// Add the edge axes to the canvas.
svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(0," + padding + ")")
    .call(xAxis);
svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(" + padding + ",0)")
    .call(yAxis);

// Add the tick axes to the canvas.
svg.append("g")         
    .attr("class", "grid")
    .attr("transform", "translate(0," + (height - padding) + ")")
    .call(make_x_axis()
        .tickSize(2 * padding - height, 0, 0)
        .tickFormat("")
    );
svg.append("g")         
    .attr("class", "grid")
    .attr("transform", "translate(" + padding + ",0)")
    .call(make_y_axis()
        .tickSize(3 * padding - width, 0, 0)
        .tickFormat("")
    );

// Create finger placement circles.
svg.selectAll("circle")
    .data(strings)
  .enter()
    .append("circle")
    .attr("cx", function(d) { return xScale(d[0]); })
    .attr("cy", function(d) { return yScale(d[1]); })
    .attr("r", dot);

/* Create labels.
svg.selectAll("text")
    .data(strings)
  .enter()
    .append("text")
    .text(function(d) { return d[0] + "," + d[1]; })
    .attr("x", function(d) { return xScale(d[0]); })
    .attr("y", function(d) { return yScale(d[1]); })
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px")
    .attr("fill", "red");
*/

