---
layout: post
title: "Auto Mount Windows NTFS Partition in Ubuntu 12.04 (later)"
comments: true
categories: tech
tags: []
---
UUID is introduced in Ubuntu 12.04 in `fstab`. Using UUID in fstab will 
make system more robust because adding or removing a SCSI disk changes the 
disk device name but not the filesystem volume label.

In this post, I am about to give you a way to add an entry in `/etc/fstab` 
to automatically mount Windows NTFS partition in Ubuntu when the system 
boots.

### Recognize the UUID of the NTFS partition
Most time, you see that which partition you want to mount, for example, 
`/dec/sda3` is the NTFS partition that you want to mount. The way to look 
up the UUID of `/dev/sda3` is the command `blkid`. You can use

{% highlight bash %}

    $ sudo blkid /dev/sda3
    /dev/sda3: LABEL="WinData" UUID="8A5EB6135EB5F851" TYPE="ntfs"
{% endhighlight %}

to look up the UUID of `/dev/sda3`. Of course, you can just type `blkid` 
without any arguments to list all partition's UUID.

### An an entry in /etc/fstab

Next step is to add an entry in `/etc/fstab`, it desinates the mount point 
and file system type and so on. The entry looks like this.

{% highlight bash %}

    UUID="8A5EB6135EB5F851"  /mnt/WinData  ntfs users,default   0 0
{% endhighlight %}

The mount point is `/mnt/WinData`, so we need to create that directory in 
the next step.

### Prepare the directory
Ok, the last step is to create the mount point directory. In this example, 
it is `/mnt/WinData`. 

{% highlight bash %}

    sudo mkdir /mnt/WinData
{% endhighlight %}


