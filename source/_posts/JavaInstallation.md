---
title: Install Java on Windows
date: 2017-11-19 02:45:45
updated: 2019-01-01 01:23:45
categories: Basic Java
tags: Java
description: Steps of installing Java and setting environment variables on Windows.
---

# Download and Install JDK.
To develop Java programs, you need to install **JDK** (Java Development Kit). You may also heard of **JRE** (Java Runtime Environment), which is essential to run Java program. Well, JRE is contained in the JDK, so all you need to do is to download and install JDK.

There are many ways to download JDK, but I recommend you to download it directly from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html) or [OpenJDK](https://openjdk.java.net/).

After downloading, install it just as you install other software. You'd better remember where you install it, because you need to set the environment variable later.

***
# Set the Environment Variables

This step is very **important**, 

1. In Control Panel, click "System and Security", then click "System"

2. Click "Advanced system settings"
{% asset_img system-setting.png [Advanced system settings] %}

3. Find "Environment Variables" under the "Advanced'" tab
{% asset_img advanced.png [Advanced] %}

4. Add the following Environment Variables

- JAVA_HOME：`C:\Program Files\Java\jdk1.8.0_102` (**Replace with the path where you installed JDK**)
- JDK_HOME：`%JAVA_HOME%`
- JRE_HOME：`%JAVA_HOME%\jre`
- CLASSPATH：`.;%JAVA_HOME%\lib;%JAVA_HOME%\jre\lib`
- Path： **Keep existing content and append** `%JAVA_HOME%\bin` 

**Note:**  You may need to append  `;` first. It depends on whether this was a `;` at the end of your original path. So you may append `;%JAVA_HOME%\bin`. Do **NOT** change the original content of "Path".


***
# Examine the Installation

Open the Terminal (On Windows, press 'Win' + 'R', then input `cmd` and press 'Enter'), input:

```bash
    java -version
```

You should see the version information of Java, which means your Java installation is successful.
{% asset_img version.png [Java Version] %}
Welcome to the world of Java.
***

**The End**

***