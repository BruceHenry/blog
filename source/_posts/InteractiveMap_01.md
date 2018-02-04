---
title: Make an Interactive Map 01 - "Let's make a colorful world!"
date: 2018-01-19 02:52:54
categories:
- Data Visualization
tags:
- JavaScript
- D3
---

#### Prefix
I am going to make a series of blogs to show you how to make all kinds of **interactive map** on a web page. Before start, you should have some basic knowledge about **HTML** and **JavaScript**.

---
#### Now, let's make a colorful world!
First, let's see what you will be able to make.

This is a map that shows the predicted median age from 2015 to 2100.

<iframe width="820" height="560" src="https://brucehenry.github.io/blog-webpage/interactive-map/01/basic-datamaps.html"></iframe>

---
#### What tools do you use?
For the above map, I use the following libraries,
- [DataMaps](http://datamaps.github.io/): A useful tool to render a `svg` map. 
- [D3](https://d3js.org/): **D3.js** is a very powerful JS library for making data visualization. (The latest version of D3 is v4, but **DataMaps** is using d3.v3).

The above tools are so powerful (especially D3) that we are just use a tiny part of them for this map. However, I will show you some more advanced interactive maps using them in the future. 

---
#### Shut up! Just give me the code!
Okay, here is the code,
##### HTML
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title>Basic Datamaps</title>
    
    <link rel="stylesheet" href="./basic-datamaps.css"/>

    <script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/topojson/1.6.9/topojson.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/datamaps/0.5.8/datamaps.all.js"></script>

</head>
<body>

<div id="map" style="width: 800px;height: 475px;position: relative; margin:auto">
</div>

<div id="input" style="width: 800px;position: relative; margin:auto">
    <table style="width:100%">
        <tr>
            <th rowspan="2"><span style="color: #040066">Year</span></th>
            <td colspan="18">
                <label for="year"></label>
                <input type="range" min="2015" max="2100" step="5" value="2015" autocomplete="off" id="year"/>
            </td>
        </tr>
        <tr style="color: #0026bf;font-size: 12px;text-align: center;">
            <td>2015</td>
            <td>2020</td>
            <td>2025</td>
            <td>2030</td>
            <td>2035</td>
            <td>2040</td>
            <td>2045</td>
            <td>2050</td>
            <td>2055</td>
            <td>2060</td>
            <td>2065</td>
            <td>2070</td>
            <td>2075</td>
            <td>2080</td>
            <td>2085</td>
            <td>2090</td>
            <td>2095</td>
            <td>2100</td>
        </tr>
    </table>
</div>

<script src="./basic-datamaps.js"></script>

</body>
</html>
```
***
##### CSS
```css
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
    appearance: none;
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
```
***
##### JavaScript
```javascript
var json_data;

function renderMap() {
    //A object to store values and colors, i.e. {}
    var data = {};

    //The array to store all the values in order to find min and max
    var values = [];

    var year = document.getElementById('year').value;
    for (var country in json_data) {
        var value = json_data[country]['data'][year];
        data[country] = {numberOfThings: value};
        values.push(value)
    }

    var minValue = Math.min.apply(null, values),
        maxValue = Math.max.apply(null, values);

    //Use d3 to convert number to color
    var colorScale = d3.scale.linear()
        .domain([minValue, maxValue])
        .range(["#afe0ff", "#040066"]);

    //Put color into the data
    for (var country in data) {
        data[country]['fillColor'] = colorScale(data[country]['numberOfThings'])
    }

    //Call DataMaps
    new Datamaps({
        element: document.getElementById('map'),
        projection: 'mercator', // big world map
        fills: {defaultFill: '#F5F5F5'},// countries don't listed in dataset will be painted with this color
        data: data,
        geographyConfig: {
            borderColor: '#d7d7d7',
            highlightBorderWidth: 2,
            highlightBorderColor: '#e66d18',
            popupTemplate: function (geo, data) {// show desired information in tooltip
                if (!data) // don't show tooltip if country don't present in dataset
                    return;
                // tooltip content
                return ['<div class="hoverinfo">',
                    '<strong>', geo.properties.name, '</strong>',
                    '<br>Median Age: <strong>', data.numberOfThings, '</strong>',
                    '</div>'].join('');
            }
        }
    });
}

//Asynchronously load the data file
d3.json("./MedianAge.json", function (data) {
    json_data = data;
    renderMap();
});

///Remove the old map and render a new map when the user change input
document.getElementById('year').oninput = function () {
    //Remove the old map
    var mapNode = document.getElementById("map");
    while (mapNode.firstChild) {
        mapNode.removeChild(mapNode.firstChild);
    }
    //Render a new map
    renderMap();
}
```
##### Part of the Data File
```json
{
    "BDI": {
        "name": "Burundi",
        "data": {
            "2015": 17.6,
            "2020": 17.5,
            "2025": 17.8,
            "2030": 18.6,
            "2035": 19.5,
            "2040": 20.4,
            "2045": 21.2,
            "2050": 22.0,
            "2055": 22.9,
            "2060": 23.8,
            "2065": 24.7,
            "2070": 25.8,
            "2075": 26.8,
            "2080": 27.8,
            "2085": 28.9,
            "2090": 29.8,
            "2095": 30.9,
            "2100": 31.9
        }
    }
}
```
---