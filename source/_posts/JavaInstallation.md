---
title: How to install Java on Windows?
date: 2017-11-19 02:45:45
tags: Java
---

## 1. Download and install JDK.

There are many ways to download JDK, but I recommend you to download it from [Oracle](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

After downloading, install it just as you install other software. You'd better remember where you install it, because you need to set the environment variable later.

---
## 2. Set the environment variables as following.

This step is very **important**, please be patient.

- JAVA_HOME：C:\Program Files\Java\jdk1.8.0_102

     **Note:**  Input the path where you installed JDK, the above example is the default path on Windows.

- JDK_HOME：%JAVA_HOME%
- JRE_HOME：%JAVA_HOME%\jre
- Path： **Append** `%JAVA_HOME%\bin` (you may need to append a `;` first. It depends on whether this was a `;` at the end of your original path. So you may append `;%JAVA_HOME%\bin`). Do **NOT** change the original content of "Path".

- CLASSPATH：.;%JAVA_HOME%\lib;%JAVA_HOME%\jre\lib


---
## 3. Examine the Installation

Open the Terminal (On Windows, press 'Win' + 'R', then input `cmd` and press 'Enter'), input:

```bash
    java -version
```

You should see the version information of Java.

---
## 4. Welcome to the world of Java.