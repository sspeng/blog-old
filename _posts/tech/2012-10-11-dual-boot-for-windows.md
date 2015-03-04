---
layout: post
title: "Dual boot for windows"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

If you install Windows and Linux in the same machine, you should deal with 
the 'dual boot'. In the past, you should install Windows firstly and then 
install Linux later if the Linux distribution you are about to install is 
Ubuntu. You will install the 'GRUB' in the MBR of the entire hard disk. The 
powerful MBR could boot Windows and Linux.

However, No all installation of Linux is as foolish as that of Ubuntu. Most 
of time, you will install the 'GRUB' manually. Here comes the topic!

Scene: I want to install both Windows and Gentoo in my machine, how to deal 
with the 'dual boot'.

Here is my partition table, use `fdisk /dev/sda -l`

{% highlight bash %}
Device Boot         Start         End      Blocks   Id  System             
/dev/sda1   *        2048      206847      102400    7  HPFS/NTFS/exFAT
/dev/sda2          206848   123381759    61587456    7  HPFS/NTFS/exFAT
/dev/sda3       123381760   123791359      204800   83  Linux
/dev/sda4       123791360   625142447   250675544    5  Extended
/dev/sda5       123793408   375451647   125829120    7  HPFS/NTFS/exFAT
/dev/sda6       375453696   383842303     4194304   82  Linux swap / Solaris
/dev/sda7       383844352   625142447   120649048   83  Linux
{% endhighlight %}

Here is some explanation:

- /dev/sda1   primary partition that is reserved by Windows automatically when partitioning for windows.
- /dev/sda2   primary partition for Windows, partiion C:\
- /dev/sda3   primary partition for Linux, the /boot partition
- /dev/sda4   whole logical partition (include the following 3 partition)
- /dev/sda5   Ligical partition for Windows, partition D:\
- /dev/sda6   logical partition for Linux, the SWAP partition
- /dev/sda7   logical partition for Linux, the ROOT partition

Well, I don't want to rewrite the MBR of the entire disk, say `/dev/sda`. I 
will keep the partition that is reserved for Windows clean.

We should install gentoo (or other distribution) with separate /boot 
partiion, in my partition table, it is the /dev/sda3

Install the `grub` (or grub-2) to the /boot partition, not the MBR
Boot in Windows 7 and , download EasyBCD from http://neosmart.net/EasyBCD/ 
and install it.

Open EasyBCD, and click `Add New Entry` button. Add an entry for the 
bootloader for Linux, specify the /boot partition
Restart the computer.


