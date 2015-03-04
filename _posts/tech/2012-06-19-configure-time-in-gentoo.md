---
layout: post
title: "Configure time in Gentoo"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

If you want to set your system time in Gentoo, especially when you want to 
dual boot your system, you should have a configuration for Gentoo. I am in 
Shanghai, Asia. So I did the following stuffs:

Copy the locale file to /etc

{% highlight bash %}
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
{% endhighlight %}

Set your time zone

{% highlight bash %}
echo "Asia/Shanghai" > /etc/timezone 
{% endhighlight %}

Modify hwclock file (/etc/conf.d/hwclock)

{% highlight bash %}
clock="local" 
clock_systohc="YES" 
{% endhighlight %}

Done
