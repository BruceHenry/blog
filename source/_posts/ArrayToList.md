---
title: How to Convert between Array and List in Java
date: 2017-11-19 02:52:54
categories: Basic Java
tags: Java
description: Introduction of converting Array and List to each other in Java.
---
In **Java**, `Array` and `List` have a lot in common. Sometimes we need to convert them to each other. Let's see how to do that.

***

# How to convert `List` to `Array`?
Suppose I have a `List<T>` named "list",
```java
    List<T> list = new ArrayList<T>();
```
Here is how to convert list, call the method `toArray(T[] array)` of List.java.
```java
    T [] array = list.toArray(new T[list.size()]);
```
**Note:** Only generic type can be done in this way, which means you cannot convert into a primitive array, like int, float, boolean, etc. If you want to convert a `List<Integer>` into a `int[]`, you have to do it with iteration yourself.
***

# How to convert `Array` to `List`?

There are two ways to convert `Array` to `List`.

- **List with Flexible Length (Recommended)**
```java
    List list = new ArrayList(Arrays.asList(array));
```
The above is recommended because it returns an `ArrayList` which has flexible length (you can add extra elements).


- **List with Fixed Length**
```java
    List list = Arrays.asList(array);
```
***

**The End**

***