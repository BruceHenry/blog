---
title: Array and List in Java
date: 2017-11-19 02:52:54
categories: Basic Java
tags: Java
description: Introduction to how to convert Array and List to each other in Java.
---
In **Java**, `Array` and `List` have a lot in common. Now I am going to introduce how to convert them to each other.

***

# How to convert `List` to `Array`?

```java
    List<T> list = new ArrayList<T>();
    T [] array = list.toArray(new T[list.size()]);
```

***

# How to convert `Array` to `List`?

There are two ways to convert `Array` to `List`.

- **Flexible Length Way (Recommended)**
```java
    List list = new ArrayList(Arrays.asList(array));
```
The above is recommended because it returns an `ArrayList` which has flexible length (you can add extra elements).


- **Easy but Inflexible Way**
```java
    List list = Arrays.asList(array);
```
***

**The End**

***