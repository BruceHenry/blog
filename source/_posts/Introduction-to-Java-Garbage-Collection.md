---
title: Introduction to Java Garbage Collection
date: 2018-02-14 19:38:22
categories:
- Advanced Java
tags:
- Java
- JVM
description: What is Garbage? Why do we discuss Garbage Collection? How to identify and collect garbage?
---
# What is Garbage?

{% asset_img garbage.png [Garbage] %}

Every time you create a new object, you consume some memory to store it. And when you no longer use it, it becomes garbage.

Unless you have infinite memory space, you need to collect memory to free the occupied memory space.

***

# Why do we discuss Garbage Collection in Java?

In **C/C++**, you need to use `free()` or `delete` to release the memory for garbage, or it will cause **memory leak**.

But in **Java**, you do not need to worry about that. JVM will automatically collect garbage, though **it does not mean that you can create objects without limit**. You can call `System.gc()` to explicitly tell JVM to do the GC, but JVM may not guarantee to do that.

When the memory is almost used up, JVM will pause the program for a while to do the GC. And here are the choices, you want the GC to be long and rare, or short and frequent. By learning the strategy of Java GC, you can optimize your Java applications by setting perfect parameters.

***

# How to identify garbage?

In general, there are two ways to identify garbage.

- Reference Counting

The easiest way is to count the reference of all the objects, then objects without being referenced are garbage. But there is a bug here, what if two garbage objects reference to each other.

- Reachability Analysis

We try to reach all the referenced objects from some root objects, then the ones without reaching are the garbage.

The root objects are called **GC Roots**. The GC Roots normally consists of local variables, static variables and active threads.

***

# How to collect garbage?

After identifying the garbage, we need to collect it. There is no one general way to do that because there are different memory area with different features. JVM actually uses different ways for different memory area.

Here are some basic strategies being mostly used,

## Mark, Delete and Compact

First mark the garbage objects, then delete them. But now the there are empty holes in the memory with probably different sizes, which is very difficult to use later.

So the next step is to compact the memory by moving the remaining object to one side of the memory.

##  Mark and Copy

First mark the garbage objects, then copy the non-garbage objects to a new area of memory.

However, this strategy needs twice memory space as it actually needs.

##  Generational Garbage Collection

Split the memory into two parts, **young generation** and **old generation**.

**Young generation** area stores objects that are newly created. Every time a object survives from GC, add one to the age of this object. When the age reaches a certain level, move this object to the **old generation** area.

Eventually, new and less important objects are in the **young generation** area, while old but important objects are in the **old generation** area.