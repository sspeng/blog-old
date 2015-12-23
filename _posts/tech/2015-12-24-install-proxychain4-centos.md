---
layout: post
title: "Install proxychains4 in CentOS"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Proxychains enables you access some websites that are blocked by GFW in
terminals. This article shows you how to install it on CentOS.

Basically, run the following commands. They are self explained.

{% highlight bash %}
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng
./configure && make && sudo make install
sudo make install-config
{% endhighlight %}

By default, `proxychains-ng` will be install in `/usr/local/`. You can also
edit the system-wide default configuration file
`/usr/local/etc/proxychains.conf`.

Change the last line `socks4  127.0.0.1 9050` to to what you want. For me, it is
`socks5  127.0.0.1 1080`.

Then you can try it: `proxychains4 wget twitter.com`
