// Self study from 
// Circles and data

// Program parameters
var data = [32, 57, 112],
    dataEnter = data.concat(293),
    dataExit = data.slice(0, 2),
    w = 360,
    h = 180,
    x = d3.scale.ordinal().domain([57, 32, 112]).rangePoints([0, w], 1),
    y = d3.scale.ordinal().domain(data).rangePoints([0, h], 2);

// Add SVG to the chart div
var svg = d3.select("#chart").append("svg")
  .attr("width", w)
  .attr("height", h);

// Get the data container
var gd = svg.selectAll(".data")
  .data([32, 57, 293])
.enter().append("g")
  .attr("class", "data")
  .attr("transform", function(d, i) { return "translate(" + 20 * (i + 1) + ",20)"; });

// TODO "enter" & "update" data?
var ed = gd.filter(function(d, i) { return i == 2; }),
    ud = gd.filter(function(d, i) { return i != 2; });

// Add a new circle
ed.append("circle")
  .attr("class", "little")
  .attr("r", 1e-6);

// Add a new data holder cell
gd.append("rect")
  .attr("x", -10)
  .attr("y", -10)
  .attr("width", 20)
  .attr("height", 20);

// Add the data to the cell
gd.append("text")
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text(String);

// Get an element object
var ge = svg.selectAll(".element")
  .data(data)
.enter().append("g")
  .attr("class", "element")
  .attr("transform", function(d) { return "translate(" + d + ",90)"; });

// Add the circle to the element
ge.append("circle")
  .attr("class", "little")
  .attr("r", Math.sqrt);

// Add the data to the element
ge.append("text")
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text(String);

// Color new data cell
ed.select("rect")
  .style("fill", "lightgreen")
  .style("stroke", "green");

// Exit TODO
var xe = ge.filter(function(d, i) { return i == 2; });

// Style the exit circle(s)
xe.select("circle")
  .style("fill", "lightcoral")
  .style("stroke", "red");

// Run the data-circle animation
d3.select("#chart button").on("click", function() {
  // Move the data to the circle coordinates
  gd
    .attr("transform", function(d, i) { return "translate(" + 20 * (i + 1) + ",20)"; })
  .transition()
    .duration(750)
    .attr("transform", function(d) { return "translate(" + d + ",90)"; });

  // Make the data cells fade out
  gd.select("rect")
    .style("opacity", 1)
  .transition()
    .duration(750)
    .style("opacity", 1e-6);

  // Enter data
  ed.select("circle")
    .attr("r", 1e-6)
  .transition()
    .duration(750)
    .attr("r", Math.sqrt);

  // Exit cicle
  xe.select("circle")
    .attr("r", Math.sqrt)
  .transition()
    .duration(750)
    .attr("r", 1e-6);

  // Exit data
  xe.select("text")
    .style("opacity", 1)
  .transition()
    .duration(750)
    .style("opacity", 1e-6);
});
