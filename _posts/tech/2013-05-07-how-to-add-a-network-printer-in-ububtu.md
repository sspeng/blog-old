---
layout: post
title: "How to add a network printer in Ububtu"
comments: true
categories: tech
tags: [Linux]
---

Motivation
===
You may ever met some problem while you are adding a network printer in
Ubuntu/Gnome from the setting panel without any reference. One of the major
problem is when getting the warning message such as

    FirewallD is not running. Network printer detection needs services mdns,
    ipp, ipp-client and samba-client enable on firewall.

When you get such kind of message, you don't need to install `firewalld`
manually. Instead, there is another interface that you can add network
printer.

Add it from command `system-config-printer`
===
As an alternative to the printer configuration tool from the new Gnome
Shell control center, you can still use `system-config-printer`. You can
open it from the command line or just press `ALT+F2`, then type
`system-config-printer` and press Enter. If no printer is added in your
system, you will get the window as following.

![system-config-printer window](/images/system-config-printer-window.png)

Click the *Add* button and choose the protocol that you want to use in the
next poped up dialog. As for me, I choose http protocol and type the URI
of the network printer server, including the IP address and port and
locations. In this example, it is
`http://192.168.0.254:631/printers/printer`, which is shown as below

![new printer window](/images/new-printer-window.png)

After clicking the *Forward* button, it will search the driver for the
protocol and install it if necessary. The next several pop-up window will
guide you to select which brand and version your printer is. You can find
out the information of it directory from the surface of the printer.

When the printer is added, you can print a test page to verify if it is
set up successfully. When a printer is set up, it will shown in the windows
as below.

![one printer in my system](/images/add-printer-finish-window.png)
