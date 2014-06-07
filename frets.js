// Set the parameters.
var width   = 300,
    height  = 300,
    xTicks  = 6,
    yTicks  = 4,
    dot     = 8,
    padding = 50;

// Get our data.
var strings = [
    [1, 0.5],
    [2, 1.5],
    [3, 2.5],
    [4, 3.5],
    [5, 0],
    [6, 0]
];

// Create scale functions.
var xScale = d3.scale.linear()
    .domain([1, d3.max(strings, function(d) { return d[0]; })])
    .range([padding, width - padding * 2]);
var yScale = d3.scale.linear()
    .domain([yTicks, 0])
    .range([height - padding, padding]);

// Define the axes.
var xAxis = d3.svg.axis()
    .scale(xScale)
    .orient("top")
    .ticks(xTicks);
var yAxis = d3.svg.axis()
    .scale(yScale)
    .orient("left")
    .ticks(yTicks);

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
         .ticks(xTicks)
}
function make_y_axis() {        
    return d3.svg.axis()
        .scale(yScale)
        .orient("left")
        .ticks(yTicks)
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

