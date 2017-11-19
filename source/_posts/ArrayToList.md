---
title: Array to List && List to Array
date: 2017-11-19 02:52:54
tags: Java
---

## Convert ArrayList to Array

{% codeblock lang:java %}
List<T> list = new ArrayList<T>();
T [] countries = list.toArray(new T[list.size()]);
{% endcodeblock %}

---

## Convert Array to ArrayList in Java

- Flexible Length Way(Recommend)
{% codeblock lang:java %}
    List list = new ArrayList(Arrays.asList(array));
{% endcodeblock %}

- Inflexible Way
{% codeblock lang:java %}
List list = new ArrayList(Arrays.asList(array));
{% endcodeblock %}