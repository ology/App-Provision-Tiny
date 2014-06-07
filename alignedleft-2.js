// Set canvas dimensions.
var width  = 600,
    height = 60;

// Get our data.
var dataset = [];
for (var i = 0; i < 10; i++) {
    var newNumber = Math.round(Math.random() * 20);
    dataset.push(newNumber);
}

// Make an SVG canvas.
var svg = d3.select("body")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

// Make circles.
var circles = svg.selectAll("circle")
    .data(dataset)
  .enter()
    .append("circle");

// Position & style the circles.
circles
    .attr("cx", function(d, i) {
        return (i * 50) + 25;
    })
    .attr("cy", height / 2)
    .attr("r", function(d) {
        return d;
    })
    .attr("fill", "yellow")
    .attr("stroke", "orange")
    .attr("stroke-width", function(d) {
        return d / 2;
    });

