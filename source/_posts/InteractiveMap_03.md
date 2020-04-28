---
title: Make an Interactive Map 03 - Interaction with Charts
date: 2018-02-5 02:52:54
updated: 2019-01-01 01:23:45
categories:
- Data Visualization
tags:
- JavaScript
- D3
description: Make the map interactive with charts (Echarts)
---
#### Preview: Map with Charts
This visualization extends from the one my previous blog.

I add some **charts** which are able to show some detailed data beyond the map. To generate the charts, I used a tool called [**Echarts**](https://echarts.apache.org/en/index.html), which is an incubator project of Apache Software Foundation.

Let's first see how it looks,
<iframe width="820" height="1060" src="https://brucehenry.github.io/blog-webpage/interactive-map/03/map_with_chart.html">You browser does not support iframe tag, <a href="https://brucehenry.github.io/blog-webpage/interactive-map/02/advanced_map.html" target="_blank">click here to visit</a>.</iframe>
<!--more-->

***

#### About ECharts
Though **D3** is powerful enough to make charts, it still costs a lot of time to make a good-looking one.

**ECharts** provides various nice charts with well-designed styles, so that is why I choose to use ECharts. I think in the future, visualization libraries like ECharts will become more popular for general use.

***

#### Show me the code! 
You can find the code at this [Github repository](https://github.com/BruceHenry/blog-webpage/tree/master/interactive-map/03).

Now let me show you how easy to make a chart with **ECharts**.

##### Step 1: Create a Container in HTML
You need to provide a container `<div>` for the charts.
```html
<div id="pie"></div>
<div id="line"></div>
```

**Also**, you need to set the size in **CSS**. Of course you can set it with JS code if you want to make a chart with responsive size.
```css
#pie {
    width: 700px;
    height: 300px;
    margin: auto;
}

#line {
    width: 700px;
    height: 300px;
    margin: auto;
}
```
##### Step 2: Use ECharts
After including the ECharts JS file (download [**here**](https://ecomfe.github.io/echarts-doc/public/en/download.html)), all you need to do is calling `init()` and `setOption()`.

Here is the **basic** code for a **pie chart**,
```javascript
echarts
    .init(document.getElementById('pie'))
    .setOption(
        {
            series: [{
                    type: 'pie',
                    data: data
                }]
        });
```

Of course you can add some more **options** like,
```javascript
echarts
    .init(document.getElementById('pie'))
    .setOption(
        {
            title: {
                text: city + ' in ' + year,
                top: '3%',
                left: '50%'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                top: '5%',
                left: 'left',
                data: legend_array
            },
            series: [{
                type: 'pie',
                radius: '60%',
                center: ['65%', '60%'],
                animation: false,
                data: data,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        });
```

And for the **line chart** of this visualization,
```javascript
echarts
    .init(document.getElementById('pie'))
    .setOption(
        {
            title: {
                text: city + ' from 2000 to 2018',
                top: '4%'
            },
            tooltip: {
                trigger: 'axis'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                axisLabel: {
                    margin: 15
                },
                data: [2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018]
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                type: 'line',
                data: data
            }]
        });
```

##### Step 3: Update the Chart
Finally, you need to add a controller to update the chart after input.

For **ECharts**, all you need to do is to call the above chart functions again. Echarts will update the data **automatically**. 

Here are some example codes,
```javascript
function render_chart() {
    /*
      echarts
        .init()
        .setOption();
    */
}

d3.select("#input").on('change', function () {
    render_chart();
});
```
***
**The End**

***