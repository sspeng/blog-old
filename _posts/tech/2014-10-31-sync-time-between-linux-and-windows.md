---
layout: post
title: "Sync Time Between Windows and  Linux"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---
If you enable your machine with dual boot of Linux and Windows, the system time in two different OS may be changed when you switch one operating system to the other. 

To fix it, just hit Start and type regedit.exe in the search box. Hit Enter and navigate to *HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation*. Right click anywhere in the right pane and hit *New > DWORD (32-bit) Value*. Name it RealTimeIsUniversal, then double click on it and give it a value of *1*.
