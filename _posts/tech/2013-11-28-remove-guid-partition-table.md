---
layout: post
title: "Remove stray GUID Partition Table (GPT) data"
comments: true
categories: tech
tags: []
---

While installing Ubuntu on a box where a fresh Windows is installed, the 
system may report that the disk contains a GUID Partition Table (GPT), 
which is left behind on a disk that was once used as a GPT disk but then 
incompletely converted to the more common Master Boot Record (MBR) form. 
In such situation, the system cannot recognize the partition of Windows. 
All that the system can see is the whole volumn.

Actually, you want to dualboot the system by installing Ubuntu within a 
specific partition, not overwriting the whole volumn.

You can achieve the goal by removing the GPT data.

## Use FixParts to remove GPT data

The FixParts program is an offshoot of my fdisk software. FixParts is a 
textmode tool that is designed to correct some common problems with 
computer partition tables. The usual symptom of the problems FixParts is 
intended to fix is a disk that shows no partitions in GParted or similar 
tools, although you know the disk to contain partitions because they're 
visible to the Linux kernel or to other partitioning software.

### Install FixParts

In Ubuntu, you can install FixParts by installing `gdisk` through command 
line `sudo apt-get install gdisk`.

### Backup your partition table

Chaing the paritition table is really really dangeous, so we'd better 
backup our partition table first. In Linux, you can use `sfdisk` to do 
this job.

{% highlight bash %}

    sudo sfdisk -d /dev/sda > partition.txt
{% endhighlight %}

Where `dev/sda` is the partition you want to modified (backup). Next time 
when you want to restore the partition table, you will be able to recover 
your partition table by reversing the program.

{% highlight bash %}

    sudo sfdisk -f /dev/sda < partition.txt
{% endhighlight %}

### Delete the GPT data

To use `fixparts`, just launch it and pass it a device filename

{% highlight bash %}

    sudo fixparts /dev/sda
{% endhighlight %}

The first check that the program preforms is for stray GPT data. If it 
finds lefeover GPT data, it warns you of this fact and ask you what to do:

    NOTICE: GPT signatures detected on the disk, but no 0xEE protective 
    partition! The GPT signatures are probably left over from a previous 
    partition table.Do you want to delete them (if you answer 'Y', this 
    will happen immediately)? (Y/N):

Now you can delete the GPT data by simply type `Y`.

That's done. Back to your installation and see if the system can find the 
previously installed Windows partitions.


## Reference
1. [FixParts Tutorial](http://www.rodsbooks.com/fixparts/)
