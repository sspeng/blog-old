---
layout: post
title: "Set up Java in Gentoo"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

This guide tell you how to set up java developping environment in Gentoo in brief

### Installing the programming environment

The first thing you need to do is to get a developing kit for java, that is JDK, to get this, use the command

{% highlight bash %}
sudo emerge sun-jdk
{% endhighlight %}

### Installing the checkstyle and findbugs

checkstyle can check and warn you about the style you use in java, and findbugs
can try to find the bugs in your program, these are two handy and quite useful
tools that can help you while you are developing java programs, to get them,
just emerge them

{% highlight bash %}
sudo emerge checkstyle findbugs
{% endhighlight %}
