---
layout: post
title: "Dual Boot Centos 6.5 with Windows 7"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Ubuntu is good because it can recognize NTFS hard drive natively. So when you
install Ubuntu after Windows, the bootloader of Ubuntu can automatically add an
entry of Windows in `grub.cfg`, so that you can successfully dual boot Ubuntu
and Windows.

However, if you install Centos after Windows, you cannot boot Windows any
longer because Centos cannot recognize Windows hard drive in NTFS format. In
order to dual boot with Centos and Windows, we should first let Centos recognize
NTFS hard drive and then add an entry to `grub.cfg`.

To install NTFS utilities in Centos, you can run the command:

{% highlight bash %}
yum install ntfs-3g
{% endhighlight %}

You may have to install `epel` before running this command.

To add an boot entry to `grub.cfg`, you need to edit file `/boot/grub/grub.cfg`
and add

{% highlight bash %}
title Windows 7
rootnoverify (hd0,0)
chainloader +1
{% endhighlight %}

Of course, we are supposing that the bootloader of Windows 7 is installed at
(hd0, 0).

In the last, reboot the computer and see if it works.
