---
layout: post
title: "如何远程Virtualbox桌面"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

通常情况下，想到远程桌面，肯定要有一个IP，然后输入这个IP来定位这台电脑。所以想到远程虚拟机的
话，应该给虚拟机一个IP，而且是局域网的IP，通常的方法是Guest OS和HOST OS采取桥接的方式，
我今天试了一下桥接，失败！

正想放弃的时候，发现VirtualBox本身有远程桌面（Remote Display）功能，
而且默认的端口是3389。因此远程虚拟机的时候，只是打开（远程）Host的一个端口。
比如，我的HOST的IP是172.18.187.250，那么我要远程虚拟机，首先应该在Host打开虚拟机，
让其中一台虚拟机开机，然后远程的时候输入172.18.187.250：:3389就可以了。
如果有多台虚拟机，那么就因该开多个端口，通常端口号5000-5080系统和其他程序比较少使用，
因此可以给我们用。

Remote Display的设定，可以在虚拟机还没开机前，在Setting中设置。