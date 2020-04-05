---
title: JVM Memory Structure
date: 2018-02-07 20:03:50
categories:
- Advanced Java
tags:
- Java
- JVM
description: Introduction to Java Virtual Machine Memory Structure
---
# What is JVM?

**JVM** (Java Virtual Machine) is the program that run your Java applications.

As part of **JRE** (Java Run Environment), JVM is the one that actually calls the `main()` method. It is also the JVM that **loads**, **links** and **initializes** the `.class` files compiled from `.java` by the compiler(javac).

***

# JVM Memory Components

There are **five** components in JVM memory: 
- Stack Area
- PC Registers
- Native Method Area
- Method Area
- Heap

**Heap** and **Method Area** are shared by all threads, while **Stack Area**, **PC Registers** and **Native Method Area** are owned by each thread.

The following diagram shows whether each of them is shared or not.
{% asset_img JVM-Memory.png [JVM Memory] %}


**Stack Area**

Every time a new thread is created, JVM creates a separate Stack Area for it. The Stack Area** consists of Local Variable Array, Operand Stack and Frame Data.

- **Local Variable Array**: Storing local variables of the method.
- **Operand Stack**: Storing the intermediate calculation results.
- **Frame Data**: Containing constant pool and Exception table.

**PC Registers**

Each thread has separate PC Registers to record the current executing instruction.

**Native Method Area**

Each thread has separate Native Method Area to store native method information.

**Method Area**

All the **class** level data including static variables are stored here.

**Heap**

All the **objects** are stored here, which means you will use the Heap every time you use the key word `new`. Besides, **Garbage Collection** mainly happens in the Heap.

***

**The End**

***
