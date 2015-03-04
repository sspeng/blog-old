---
layout: post
title: "Make clean target in qmake"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---
I love to remove the compiled binary file while I execute the 'make
clean' command, so I need to add the following line to the .pro file.

{% highlight bash %}
QMAKE_CLEAN += ${TARGET}
{% endhighlight %}

you can add the above line to the qmake's default file:
/usr/share/qt4/mkspecs/default/qmake.conf
