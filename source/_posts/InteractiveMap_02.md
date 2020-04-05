---
title: Make an Interactive Map 02 - Lines in the Map
date: 2018-01-31 02:52:54
categories:
- Data Visualization
tags:
- JavaScript
- D3
description: Introduction to how to draw lines in a map using D3.js
---

#### Preview: Lines in the Map
This map shows the connections among different locations.

<iframe width="820" height="520" src="https://brucehenry.github.io/blog-webpage/interactive-map/02/advanced_map.html">You browser does not support iframe tag, <a href="https://brucehenry.github.io/blog-webpage/interactive-map/02/advanced_map.html" target="_blank">click here to visit</a>.</iframe>

---
#### What tools do you use?
I still use the same tools as the previous blog ([Make an Interactive Map 01](https://brucehenry.github.io/blog/public/2018/01/19/InteractiveMap_01/)): [DataMaps](http://datamaps.github.io/) and [D3](https://d3js.org/).

However, this time functions in **D3** is largely used to manipulate `svg` elements based on the map.

---
#### Show me the code! 
You can find the code at this [Github Repository](https://github.com/BruceHenry/blog-webpage/tree/master/interactive-map/02). 

Let me briefly introduce the steps of making this data visualization. I will skip the **rendering map** part that has already covered in my previous blog.

##### Step 1: Set Projection with `d3.geo`
**Projection** means the center of map, so we need it to convert real-world coordinates(longitude and latitude) into locations in our map. It should be **updated** every time user drag or zoom in/out.

Projection contains **center**, **scale**, and **translate**.
- **Center** is an array of longitude and latitude.
- **Scale** is the height of the map, which means the relative size in the map.
- **Translate** is to set the coordinate origin to be the center of map instead of top-left corner, so the values should be half of width and height.

```javascript
//Get width and height of the outer <div> to set projection
var map_div = d3.select('#map').node().getBoundingClientRect();
var width = map_div.width;
var height = map_div.height;

//This value is the initial scale of map. 
var default_scale = 500;

var projection = d3.geo.equirectangular()
    .center([-98, 38])//[longitude, latitude], the approximate center of USA is [-98, 38].
    .scale(default_scale)//Initial scale
    .translate([width / 2, height / 2]);
```
##### Step 2: Use D3 to Draw SVG Shapes
This is such a powerful part of D3. You can manipulate SVG elements easily with D3. Let's see how to do that.

First you need to create a `<svg></svg>` element and have an **array** of data.

Then set the attributes using D3. Use `data(data_source).enter()` to set the data, `append(tag)` to add element, `attr()` to set an attribute, and `style()` to set styles. Also, use `on()` to add listener event for interaction.

For circles,
```javascript
//Append all circles into a <g> tag in order to manipulate them easily.
var circles = d3.select('svg')
    .append('g')
    .attr('id', 'circles')
    .selectAll('circle');

//Set attributes and styles of circles based on the data
circles.data(data)
    .enter()
    .append('circle')
    .attr('fill', '#ffb043')
    .attr('r', 4)
    .attr('cx', function (d) {
        return projection(d.location)[0];
    })
    .attr('cy', function (d) {
        return projection(d.location)[1];
    })
    .on('click', function (d) {
        //Click Event
    })
```

For lines, to add animation use ` .transition().duration(millisecond)`
```javascript
var colorScale = d3.scale.category20();//To make the lines be in different colors.

//Append all lines into a <g> tag in order to manipulate them easily.
var lines = d3.select('svg')
        .append('g')
        .attr('id', 'lines')
        .selectAll('line');

//Set attributes and styles of lines based on the data
lines.data(data)
    .enter()
    .append('line')
    .attr('x1', projection(location_data[city])[0])
    .attr('y1', projection(location_data[city])[1])
    .attr('x2', projection(location_data[city])[0])
    .attr('y2', projection(location_data[city])[1])
    .style('stroke-width', '3px')
    .style('stroke', function () {
        return colorScale(Math.random());
    })
    .style('stroke-linecap', 'round')
    .transition()
    .duration(animation_length)
    .attr('x2', function (d) {
        return projection(location_data[d])[0];
    })
    .attr('y2', function (d) {
        return projection(location_data[d])[1];
    })
```
**Putting the above code into functions will make it easier when updating.**

##### Step 3:  Add Controller and Event-Listenner
The most important one is the one for the map. 
```javascript
d3.select('#map').call(
    d3.behavior.zoom()
        .on('zoom', function () {
            var scale = d3.event.scale;
            //Update projection (projection will be changed after zooming or dragging)
            projection = d3.geo.equirectangular()
                .center([-98, 38])
                .scale(default_scale * scale)
                .translate([width / 2 * scale + d3.event.translate[0], height / 2 * scale + d3.event.translate[1]]);

            //Your functions toupdate map and svg shapes...
        })
);
```
Also controllers for the other inputs.
***
**The End**

***