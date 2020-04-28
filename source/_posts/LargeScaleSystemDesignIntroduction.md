---
title: Large Scale System Design Introduction
date: 2020-04-07 01:23:45
updated: 2020-04-21 01:23:45
categories:
- System Design
tags:
- System Design
description: Introduction to Large Scale System Design
---
# Initial Phase
First, build a simple system as following, a basic application server with a database server.

{% asset_img 01Basic.png [Basic] %}

***

# Bring in Cache
When the amount of incoming request increases, the database first starts crashing due to disk IO bandwidth limit, though SSD hard disk has much better performance nowadays. To avoid reaching IO limit, we could bring **cache** into the architecture. **Redis** and **Memcached** are 2 most common used in-memory cache tools. Redis is single-thread and more popular because it supports more data structure, data-persistence and cluster mode. When the application is going to retrive data, it will first try to read in the cache. With cache, the amount of request going to database will be reduced , as most requests are reading the data instead of writing.

As for application, a **cache update mechanism** should be added to keep the cache up-to-date.

{% asset_img 02Cache.png [Cache] %}

***

# Separate Read and Write
For data-driven company, data is the most valuable asset. Therefore, data stored in the database must have a second backup, or even several replicas. Also for most database usage, READ is much more often than WRITE. So in order to reduce the pressure of database server, we can separate READ operation from our master database, as following,

{% asset_img 03ReadWriteDB.png [ReadWriteDB] %}

***

# Load Balancer and CDN
## Load Balancer
For an application (Java/Python/PHP) server, QPS(Query Per Second) limit is about 1000. So when requests increase, the application server could be the new bottleneck. Then multiple application instances should be run to share the high-concurrent requests. Therefore, to distribute requests equally into different application instances, a load balancer is needed. **Nginx** and **HAProxy** are 2 most famous load balancers.

## CDN
For most websites, static files are rarely changed. And some of the static files like image are relatively too large for mobile users. So these static files could be cached by CDN (content Delivery Network). Also, CDN provider normally have multiple servers located in different regions, so CDN could also speed up web pages for users who locates far from the actual server.

If the application has already been implemented, make sure to check that no global data is stored locally, because the application now consists of multiple instances.

{% asset_img 04CDN.png [CDN] %}

***

# More Data
## NoSQL Database
For a complex application, it is difficult to store all kinds of data in the relational database. So now it is time to bring in NoSQL database. Most NoSQL databases are designed for large-scale use. 

## Search Engine
For some application, search could be an essential feature. An search engine tool like ElasticSearch could help here. It can also be used for log search, which is important for monitoring applications.

{% asset_img 05SearchEngine.png [SearchEngine] %}

***

# Separate Service
## Multiple Applications
As an application grows, it could be too large to maintain. Also for a development team, there could be applications that use some basic features in common, like user management. Therefore, some common used services could be separated from applications. For different services, normally they do not share common data in the database. So we can also use isolated database for each service, which reduces the workload of each database further.

## Message Queue
Imagine a scenario, an application called A is trying send a message to another application called B, and B is busy and does not respond immediately. Now A has to wait for the response from B, so that A is blocked. What if A needs to notify more than multiple applications/services, A could be blocked for seconds. To avoid this, message queue tools are needed. With message queue, A could just send the message to message queue, and message queue will do the rest notification. This frees A from being blocked, and enables A to deal with its following work.

And here is our final phase,

{% asset_img 06Service.png [Service] %}