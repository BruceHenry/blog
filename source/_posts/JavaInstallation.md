---
title: Install Java on Windows
date: 2017-11-19 02:45:45
categories: Basic Java
tags: Java
description: Steps of installing Java and setting environment variables on Windows.
---
# What is Java? Why Java?

**Java** is a object-oriented programming language owned by Oracle now.

The original designer of Java loves the coffee from Java island in Indonesia, that is why the logo of Java is a cup of coffee.

{% asset_img java-oracle.png [Java and Oracle] %}

**Comparing with other programming languages**, one unique thing about Java is that Java programs run in the **JVM**(Java Virtual Machine). And thanks to that, Java programs are called **WORA** (Write Once Run Everywhere), which means you can run your Java code on any platform with JVM.

However, in most cases, the large usage of Java today is not because its cross-platform feature but the active community and mature solutions of Java.

***

# Download and Install JDK.
To run Java programs, you need to install **JRE**(Java Runtime Environment), which contains JVM. And to develop Java programs, you need to install **JDK**(Java Development Kit). Well, JRE is contained in the JDK, so all you need to do is to download and install JDK.

There are many ways to download JDK, but I recommend you to download it directly from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

After downloading, install it just as you install other software. You'd better remember where you install it, because you need to set the environment variable later.

***
# Set the Environment Variables

This step is very **important**, please be patient.

1. Open 'System'
2. Click 'Advanced system settings'
{% asset_img system-setting.png [Advanced system settings] %}
3. Find 'Environment Variables' in the 'Advanced' tab
{% asset_img advanced.png [Advanced] %}

4. Add the following Environment Variables

- JAVA_HOME：C:\Program Files\Java\jdk1.8.0_102

**Note:**  Input the path where you installed JDK, the above example is the default path on Windows(x64).

- JDK_HOME：%JAVA_HOME%
- JRE_HOME：%JAVA_HOME%\jre
- Path： **Append** `%JAVA_HOME%\bin`

**Note:**  You may need to append  `;` first. It depends on whether this was a `;` at the end of your original path. So you may append `;%JAVA_HOME%\bin`. Do **NOT** change the original content of "Path".

- CLASSPATH：.;%JAVA_HOME%\lib;%JAVA_HOME%\jre\lib


***
# Examine the Installation

Open the Terminal (On Windows, press 'Win' + 'R', then input `cmd` and press 'Enter'), input:

```bash
    java -version
```

You should see the version information of Java, which means you have successfully installed Java.
{% asset_img version.png [Java Version] %}
Welcome to the world of Java.
***

**The End**

***