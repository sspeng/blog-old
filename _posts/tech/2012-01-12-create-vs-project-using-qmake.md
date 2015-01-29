---
layout: post
title: "Create VC (VS) Project Using Qmake"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

It is able to convert the Qt project into Visual Studio project, even the 
console C++ project without any GUI interative. In this way, you can 
develop an console project with GCC and Makefile under Linux and convert 
it to a Visual Studio project when you want to deliver it to 
windows.

## Create a pure console application

If you create the .pro file using the `qmake -project` with the default 
settings, it will create a basic app project, not in console mode. After 
converting this project into a Visual Studio project, the visual studio 
compiler will complain, as it is not a console project, but a window 
project.

To solve this problem, you can modify the variable in .pro file, making it 
a console project. Add the console property to the CONFIG variable, and 
remove qt property from it:

{% highlight bash %}
CONFIG += console CONFIG -= qt 
{% endhighlight %}


### Advanced configuration for platform dependent

What's more, adding the console property to the CONFIG variable makes no 
difference in Linux. So you can have a better specification that is only 
for windows:

{% highlight bash %}
CONFIG -= qt win32 { CONFIG += console } 
{% endhighlight %}


## Convert Command

If you have made the preparation, the last thing for you is to enter the 
command to perform the convertion. The command is quite simple.

Enter the root directory of the project where the .pro file residents.
Enter the following command:

{% highlight bash %}
qmake -spec win32-msvc2008 -tp vc 
{% endhighlight %}

It will generate the .vcproj file in the directory.

## FAQ

##### Q: I got the following warning when converting to VS project.

{% highlight bash %}
WARNING: Unable to generate output for: /tmp/hello/Makefile [TEMPLATE vcapp]
{% endhighlight %}

A: Maybe you the command you enter is not the one I mentioned above. I 
got the same warning if I just enter qmake -tp vc.

##### Q: What does -spec mean?

A: -spec will temporary modify the QMAKESPEC variable. I have extact 
the document of QMAKESPEC in appendex.

## Appendix

#### QMAKESPEC

This variable contains the name of the qmake configuration to use when 
generating Makefiles. The value of this variable is typically handled 
by qmake and rarely needs to be modified.

Use the QMAKESPEC environment variable to override the qmake 
configuration. Note that, due to the way qmake reads project files, 
setting the QMAKESPEC environment variable from within a project file 
will have no effect.
