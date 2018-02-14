---
title: Make an Interactive Map 02 - "Let's start an airline company!"
date: 2018-01-31 02:52:54
categories:
- Data Visualization
tags:
- JavaScript
- D3
---

#### What is this map?
This map shows the change of relations among nodes by time. Well, you can consider it as an airline company which changes its airlines every year.

<iframe width="820" height="520" src="https://brucehenry.github.io/blog-webpage/interactive-map/02/advanced_map.html">You browser does not support iframe tag, <a href="https://brucehenry.github.io/blog-webpage/interactive-map/02/advanced_map.html" target="_blank">click here to visit</a>.</iframe>

#### What tools do you use?
I still use the same tools as the last blog ([Make an Interactive Map 01](https://brucehenry.github.io/blog/public/2018/01/19/InteractiveMap_01/)): [DataMaps](http://datamaps.github.io/) and [D3](https://d3js.org/).

However, this time I use d3 to manipulate `svg` elements based on the map. To understand the code, you may need to have some basic knowledge of D3.

---
#### Show me the code! 
You can find the code at this [Github repository](https://github.com/BruceHenry/blog-webpage/tree/master/interactive-map/02).

##### HTML
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title>Advanced Interactive Map</title>
    <link rel="stylesheet" href="./advanced_map.css"/>

    <script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/topojson/1.6.9/topojson.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/datamaps/0.5.8/datamaps.all.js"></script>
</head>
<body>

<div id="map"></div>

<div id="input">
    <label for="city">City</label>
    <select id="city" autocomplete="off">
        <option disabled selected value> -- select a city --</option>
    </select>

    <table>
        <tr>
            <th rowspan="2">Year</th>
            <td colspan="21">
                <label for="year"></label>
                <input type="range" min="2000" max="2018" step="1" value="2000" autocomplete="off" id="year"/>
            </td>
        </tr>
        <tr>
            <td>2000</td>
            <td>2001</td>
            <td>2002</td>
            <td>2003</td>
            <td>2004</td>
            <td>2005</td>
            <td>2006</td>
            <td>2007</td>
            <td>2008</td>
            <td>2009</td>
            <td>2010</td>
            <td>2011</td>
            <td>2012</td>
            <td>2013</td>
            <td>2014</td>
            <td>2015</td>
            <td>2016</td>
            <td>2017</td>
            <td>2018</td>
        </tr>
    </table>
    <ul>
        <li>Try selecting a city (click on the map or use dropdown list).</li>
        <li>Try dragging the year slider.</li>
        <li>Try zooming in and dragging the map.</li>
    </ul>
</div>

<script src="./advanced_map.js"></script>
</body>
</html>
```
***
##### JavaScript
```javascript
var relation_data;//relation data among cities
var location_data;//location data of cities

//Get width and height of the outer <div> to set projection
var map_div = d3.select('#map').node().getBoundingClientRect();
var width = map_div.width, height = map_div.height;

//This values means the initial scale of map, also how much you want the map to zoom in: d3.geo.scale = projection_scale * mouse_event_zoom
var projection_scale = 500;

//Projection is a property to set the center and scale of map. Also, we can use it to get position in the map from real world geo coordinates.
var projection = d3.geo.equirectangular()
    .center([-98, 38])//[longitude, latitude]
    .scale(projection_scale)//Initial scale
    .translate([width / 2, height / 2]);

//Pop up a box when mouse is over a city
var popup = d3.select('body')
    .append('div')
    .attr('class', 'popup')
    .style('opacity', 0);//Invisible


function renderMap(projection) {
    //Remove the previous map elements
    const mapNode = document.getElementById("map");
    while (mapNode.firstChild) {
        mapNode.removeChild(mapNode.firstChild);
    }

    //Render new map
    new Datamaps({
        element: document.getElementById('map'),
        projection: 'mercator',
        setProjection: function (element) {
            const path = d3.geo.path().projection(projection);
            return {path: path, projection: projection};
        },
        fills: {
            defaultFill: '#8ebdee'
        },
        geographyConfig: {
            popupOnHover: false, //disable the popup while hovering
            highlightOnHover: false
        }
    });
}

//Function to draw circles(cities) on the map.
function drawCity(location_data, projection) {
    //Remove previous circles
    d3.select('#circles').remove();

    //Put the data into an array. The parameter of d3.(Select_Function).data() must be iterable.
    var data = [];
    for (var city in location_data) {
        data.push({
            city: city,
            location: location_data[city]
        });
    }

    //Append all circles into a <g> tag in order to manipulate them easily.
    var circles = d3.select('svg')
        .append('g')
        .attr('id', 'circles')
        .selectAll('circle');

    //Set attributes and styles of circles based on the data
    circles.data(data)
        .enter()
        .append('circle')
        .attr('fill', '#ff919f')
        .attr('r', 4)
        .attr('cx', function (d) {
            return projection(d.location)[0];
        })
        .attr('cy', function (d) {
            return projection(d.location)[1];
        })
        .on('click', function (d) {
            if (d3.select("#city").property("value") === d.city)
                return;
            d3.select('#city').property('value', d.city);
            drawLine(relation_data, location_data, projection, 300);
        })
        .on('mouseover', function (d) {
            d3.select(this).attr('r', 7).style('cursor', "pointer");
            popup.style('opacity', .8)
                .style('left', (d3.event.pageX) + 'px')
                .style('top', (d3.event.pageY - 20) + 'px')
                .text(d.city);
        })
        .on('mouseout', function () {
            d3.select(this).attr('r', 4);
            popup.transition()
                .duration(500)
                .style('opacity', 0);
        });
}

//Function to draw lines(relations) on the map.
function drawLine(relation_data, location_data, projection, animation_length) {
    //Remove previous circles
    d3.select("#lines").remove();

    //Get values from the input
    var year = d3.select("#year").property("value");
    var city = d3.select("#city").property("value");

    //If user drag the year slider without selecting any cities, return directly.
    if (!city)
        return;

    var data = relation_data[city][year];

    var colorScale = d3.scale.category20();

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
}


//Asynchronously load the data files
d3.json("./city_location.json", function (city_location) {
    d3.json("./data.json", function (data) {
        location_data = city_location;
        relation_data = data;

        //Append cities into the city selection list
        var city_selector = d3.select('#city');
        for (var city in location_data) {
            city_selector.append('option').text(city);
        }

        renderMap(projection);//Render the map after loading the data
        drawCity(location_data, projection);//Draw cities after loading the data
    });
});

//Handle zoom (including drag) event
d3.select('#map').call(
    d3.behavior.zoom()
        .scaleExtent([0.5, 5])
        .on('zoom', function () {
            //Update projection (projection will be changed after zooming or dragging)
            projection = d3.geo.equirectangular()
                .center([-98, 38])
                .scale(projection_scale * d3.event.scale)
                .translate([width / 2 + d3.event.translate[0], height / 2 + d3.event.translate[1]]);

            renderMap(projection);
            drawCity(location_data, projection);
            drawLine(relation_data, location_data, projection, 0);
        })
);

//Handle city selector change
d3.select("#city").on('change', function () {
    drawLine(relation_data, location_data, projection, 300);
});

//Handle year input change
d3.select("#year").on('input', function () {
    renderMap(projection);
    drawCity(location_data, projection);
    drawLine(relation_data, location_data, projection, 0);
});
```
***
##### CSS
```css
.popup {
    position: absolute;
    text-align: center;
    width: 80px;
    height: 15px;
    padding: 2px;
    font: 12px sans-serif;
    background: #ebebeb;
    border: 0;
    border-radius: 8px;
    pointer-events: none;
}

#map {
    width: 800px;
    height: 300px;
    position: relative;
    margin: auto;
}

#input {
    width: 800px;
    position: relative;
    margin: auto;
}

label {
    color: #37ca98;
    font-size: 20px;
    font-weight: bold;
}

table {
    width: 100%;
}

th {
    color: #e66d18;
    font-size: 20px;
    text-align: left;
}

tr {
    color: #0026bf;
    font-size: 12px;
    font-weight: bold;
    text-align: center;
}

#year {
    -webkit-appearance: none;
    width: 98%;
    height: 15px;
    border-radius: 5px;
    background: #99ccff;
    outline: none;
    opacity: 0.7;
    -webkit-transition: .2s;
    transition: opacity .2s;
}

#year::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 25px;
    height: 25px;
    border-radius: 50%;
    background: #0462ff;
    cursor: pointer;
}

#year::-moz-range-thumb {
    width: 25px;
    height: 25px;
    border-radius: 50%;
    background: #0462ff;
    cursor: pointer;
}

#year::-moz-range-track {
    background: none;
}

ul {
    color: #00242b;
    font-weight: bold;
}
```