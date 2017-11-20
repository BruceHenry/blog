---
title: Java Installation
date: 2017-11-19 02:45:45
tags: Java
---

## 1. Download JDK and install it.

[Click here to download](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

---
## 2. Set the environment varibles as following,

- JAVA_HOME：C:\Program Files\Java\jdk1.8.0_102

     **Note:**  Input the directory you installed the JDK, the above example is the default path on Windows.

- JDK_HOME：%JAVA_HOME%
- JRE_HOME：%JAVA_HOME%\jre
- Path：......;%JAVA_HOME%\bin

    **Note:** Do **NOT** change the original content of "Path".

- CLASSPATH：.;%JAVA_HOME%\lib;%JAVA_HOME%\jre\lib


---
## 3. Examine the Installation

Open the Terminal, input:

{% codeblock lang:bash %}
    java -version
{% endcodeblock %}

You should see the version information of Java.