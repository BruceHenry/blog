---
title: Make an Interactive Map 01 - Colorful World Map
date: 2018-01-19 02:52:54
categories:
- Data Visualization
tags:
- JavaScript
- D3
description: Make a interactive world map with countries in different colors based on the data.
---

#### Prefix
I am going to make a series of blogs to show you how to make all kinds of **interactive map** on a web page. Before start, you should have some basic knowledge of **HTML** and **JavaScript**.

---
#### Preview: A Colorful World!
First, let's have a preview of what the map looks like. 

This is a world map that shows the median age of each country from 2015 to 2100 predicted by [United Nations](https://esa.un.org/unpd/wpp/Download/Standard/Population/).

<iframe width="820" height="540" src="https://brucehenry.github.io/blog-webpage/interactive-map/01/basic-datamaps.html">You browser does not support iframe tag, <a href="https://brucehenry.github.io/blog-webpage/interactive-map/01/basic-datamaps.html" target="_blank">click here to visit</a>.</iframe>

Also, you can find a more advanced example [here](https://brucehenry.github.io/WorldPopulationData/).

---
#### What tools do you use?
For the above map, I use the these libraries,
- [**DataMaps**](http://datamaps.github.io/): A useful tool to render a `svg` map. Many basic mouse event interactions like changing fill/border color when mouseover and are built in. 
- [**D3**](https://d3js.org/): A very powerful JS library, especially in making data visualization.

One thing you should know, **DataMaps** is using the version 3 of D3 so that I'd better use the same version in my code.

---
#### Show me the code! 
Sure, you can find all the code at this [Github Repository](https://github.com/BruceHenry/blog-webpage/tree/master/interactive-map/01). Now let me briefly introduce the steps of making this data visualization. 
 
##### Step 0: Include the JavaScript Libraries.
```html
<script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/topojson/1.6.9/topojson.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/datamaps/0.5.8/datamaps.all.js"></script>
```

##### Step 1: Load the Data
I use `d3.json()` to load the data file.
```javascript
var json_data;
d3.json("./MedianAge.json", function (data) {
    json_data = data;
});
```
##### Step 2: Process the Data
The data for **Datamaps** must be in an specific format like: 
```javascript
{
    '3-digit country code':{
        'numberOfThings': value,
        'fillColor':color
    }
}
```

Also, you need provide the **min** and **max** values in order to set the scale of color. Here I use D3 to set the color scale.

This step actually depends on the format of data you have, so here I just show you an example.
```javascript
var values = [];//The array to store all the values in order to find min and max

//Iterate the data array to retrieve the value of each country
for (var country in data_source) {
    values.push(data_source[country])
}

//Get min and max values to set the color scale
var minValue = Math.min.apply(null, values),
    maxValue = Math.max.apply(null, values);

//Use d3 to convert number to color
var colorScale = d3.scale.linear()
    .domain([minValue, maxValue])
    .range(["#afe0ff", "#040066"]);

//Put color into the data array for each country
for (var country in data) {
    data[country]['fillColor'] = colorScale(data[country]['numberOfThings'])
}
```

##### Step 3: Render the Map from the Data
First create a `div` tag in the HTML file. `<div id="map"></div>` 

Then call `Datamaps()` function to render the map. You should set the map styles here. 
```javascript
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
```

##### Step 4: Update the Map According to the Input from User 
First add a input in HTML. It could be a either `input` or `select` tag. Here is my `input`.
```html
 <input type="range" min="2015" max="2100" step="5" value="2015" autocomplete="off" id="year"/>
```
Then wirte an function to render the map. 
```javascript
function render_map() {
    //1. Get the new data.
    //2. Call Datamaps() according to the new data.
}
```

And finally add a **controller**.
```javascript
document.getElementById('year').oninput = function () {
    render_map();//Render a new map when the year is changed. You may need to remove the previous map.
};
```
##### Step 5: Style Your Page
You can use **CSS** to make you page prettier. I will skip this step.

***
**The End**

***