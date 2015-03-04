---
layout: post
title: "Install fonts in Gentoo"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Giving that you have installed your window manager properly, KDE, GNOME, or Xfce.
To support the UTF-8 fonts displaying, you should install the following fonts for CJK.

{% highlight bash %}
 emerge -j  media-fonts/font-isas-misc media-fonts/wqy-bitmapfont \
   media-fonts/bitstream-cyberbit media-fonts/droid media-fonts/ja-ipafonts \
   media-fonts/wqy-microhei media-fonts/wqy-zenhei
{% endhighlight %}

rebuild the font cache with the following command:

{% highlight bash %}
fc-cache -fv
{% endhighlight %}

enable wqy-bitmapsong with the command:

{% highlight bash %}
eselect fontconfig enable 85-wqy-bitmapsong.conf
{% endhighlight %}

reboot your system, and fireup a browser, have a look at if the chinese fonts are display properly.
