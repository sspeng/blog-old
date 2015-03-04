---
layout: post
title: "Clear memory cache in Linux"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Just by using a really simple command:

{% highlight bash %}
sync; echo 3 > /proc/sys/vm/drop_caches
{% endhighlight %}

- echo 3 is clearing pagecache, dentries and inodes
- echo 1 to free pagecache only 
- echo 2 to free dentries and inodes.
