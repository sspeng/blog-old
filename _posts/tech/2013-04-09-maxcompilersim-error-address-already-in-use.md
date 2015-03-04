---
layout: post
title: "Maxcompilersim error: Address already in use"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

If you compile the tutorial code but the compiler complains, with the following error:

{% highlight bash %}
/opt/maxeler/bin/maxcompilersim -c`java -cp ../../../bin:/opt/maxeler/lib/MaxCompiler.jar config.BoardModel` restart
Killing simulated system...
Simulated system killed
Error binding to socket maxelerosd.sock: Address already in use
ERROR: Failed to start maxeleros daemon.
make: ** [run-sim] Error 1
{% endhighlight %}

The Solution is:

find the PID of maxeleros with the command:

{% highlight bash %}
  /usr/sbin/lsof | grep maxeleros
{% endhighlight %}

kill existing maxeleros process (root privilege required, maybe)

{% highlight bash %}
  sudo kill -9 pid_of_maxeleros
{% endhighlight %}

export the following variables

{% highlight bash %}
export MAXELEROSDIR=$MAXCOMPILERDIR/lib/maxeleros-sim
export LD_PRELOAD=$MAXELEROSDIR/lib/libmaxeleros.so:$LD_PRELOAD
{% endhighlight %}

recompile the code and run the program
