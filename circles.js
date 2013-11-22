// Self study from 
// Circles and data

var svg = d3.select("#chart-13").append("svg")
  .attr("width", w)
  .attr("height", h);

var gd = svg.selectAll(".data")
  .data([32, 57, 293])
.enter().append("g")
  .attr("class", "data")
  .attr("transform", function(d, i) { return "translate(" + 20 * (i + 1) +
",20)"; });

var ed = gd.filter(function(d, i) { return i == 2; }),
  ud = gd.filter(function(d, i) { return i != 2; });

ed.append("circle")
  .attr("class", "little")
  .attr("r", 1e-6);

gd.append("rect")
  .attr("x", -10)
  .attr("y", -10)
  .attr("width", 20)
  .attr("height", 20);

gd.append("text")
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text(String);

var ge = svg.selectAll(".element")
  .data(data)
.enter().append("g")
  .attr("class", "element")
  .attr("transform", function(d) { return "translate(" + d + ",90)"; });

ge.append("circle")
  .attr("class", "little")
  .attr("r", Math.sqrt);

ge.append("text")
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text(String);

ed.select("rect")
  .style("fill", "lightgreen")
  .style("stroke", "green");

var xe = ge.filter(function(d, i) { return i == 2; });

xe.select("circle")
  .style("fill", "lightcoral")
  .style("stroke", "red");

d3.select("#chart-13 button").on("click", function() {
gd
    .attr("transform", function(d, i) { return "translate(" + 20 * (i + 1) +
",20)"; })
  .transition()
    .duration(750)
    .attr("transform", function(d) { return "translate(" + d + ",90)"; });

gd.select("rect")
    .style("opacity", 1)
  .transition()
    .duration(750)
    .style("opacity", 1e-6);

ed.select("circle")
    .attr("r", 1e-6)
  .transition()
    .duration(750)
    .attr("r", Math.sqrt);

xe.select("circle")
    .attr("r", Math.sqrt)
  .transition()
    .duration(750)
    .attr("r", 1e-6);

xe.select("text")
    .style("opacity", 1)
  .transition()
    .duration(750)
    .style("opacity", 1e-6);
});
