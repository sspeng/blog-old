---
layout: post
title: "Lenovo G480 Wired Network Driver Installtion"
comments: true
categories: tech
tags: []
---

My laptop *Lenovo G480* works fine except that most Linux distribution
doesn't have wired ethernet driver integrated in their distribution. So I have to
install the wired ethernet driver manually after installing the Linux.

The driver that will be manually installed is like a patch to the kernel.
It is generally considered that the version of the driver should be newer
than that of kernel. In a word, you had better download the newest version
of the driver.

The repository of the driver is
https://www.kernel.org/pub/linux/kernel/projects/backports/ ; download the
latest one. For example, in Ubuntu 13.04 whose kernel is 3.8.0

# Preparation #
As explained above, the driver is like a patch to the kernel. So you need
the source code of the currently running kernel and some essential building
tools. They could be installed with the following command.

{% highlight bash %}

    sudo apt-get install build-essential linux-headers-generic
{% endhighlight %}

# Install Drivers #
The version of the driver should be greater than that of the kernel. In 
this section, I will list the correct version of drivers that works for the 
kernel.

## Ubuntu 13.04 with kernel 3.8.0 ##

If you install Ubuntu 13.04, then the default version of the kernel is 
3.8.0. You can download `compat-drivers-2013-03-04-u.tar.bz2` from the 
driver repository listed in the previous section. Or just follow the 
command below.

{% highlight bash %}

    wget https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/04/compat-drivers-2013-03-04-u.tar.bz2
    tar xavf compat-drivers-2013-03-04-u.tar.bz2
    cd compat-drivers-2013-03-04-u
    ./scripts/driver-select alx
    make
    sudo make install
    reboot
{% endhighlight %}

# Defect #
If your laptop sleeps or hibernates, you have to type 
`sudo modprobe -r alx && sudo modprobe alx` to use the ethernet again.
