---
layout: post
title: "Mimic nest loop using chained counter and advanced counter"
description: ""
categories: tech
tags: [FPGA]
---


## Use chained counters

In the FPGA kernel designing, it is very common to mimic the CPU for loop. 
The Maxeler Kernel has already provided a similar approach to mimic the for 
loop called *chained counter*. A counter chain consist of a number of 
counters which are linked together in such a way as to mimic nest loops. 
The value of the chained counter is similar to the index of the for loop. 
For example, if you have the following CPU code

{% highlight cpp %}

    for (i = 0; i < 6; i += 2) {
      for (j = 0; j < 2; j++) {

      }
    }
{% endhighlight %}

You can mimic the for loop by the use of chained counter, such as 

{% highlight cpp %}

    CounterChain chain = control.count.makeCounterChain();
    HWVar i = chain.addCounter(6, 2); // 6 is the max value, 2 is the increment
    HWVar j = chain.addCounter(2, 1); // 2 is the max value, 1 is the increment

    i = i.cast(hwUInt(32));
    j = j.cast(hwUInt(32));
{% endhighlight %}

## Use advanced counters

Advanced counter is the super set of counters, including simple counter and 
chained counter. As for the above example, the counter chain links two 
counters together. In this part, we also need to create 2 advanced counter, 
and link then up (set their relationship).

In this chained counter version, we can think that the counter `i` is 
disable (that is, showing the previous value, doesn't to increse) while 
counter `j` is counting. The counter `i` is only enabled (that is, increase 
the previous value by 1) when counter `j` wraps (that is, the counter 
counts up to max - 1, then restarts counting from 0). We can implement the 
above meaning with the advanced counter.

{% highlight cpp %}

    Count.Params counterJParam = control.count.makeParams(width); // width of counter
    counterJParam = counterJParam.withMax(2); // max value
    Counter counterJ = control.count.makeCounter(counterJParam);

    Count.Params counterIParam = control.count.makeParams(width);
    counterIParam = counterIParam.withMax(6);
    counterIParam = counterIParam.withInc(2); // increament
    counterIParam = counterIParam.withEnable(counterJ.getWrap()); // when to enable
    Counter counterI = control.count.makeCounter(counterIParam);
{% endhighlight %}

## Comparision

Both the chained counter's max value and advanced counter's max value can 
be set with the `HWVar` data type, which means the max value could be read 
from the *scalar input*. However, neither the chained counter's increament 
nor the advanced counter's increament can be set with `HWVar` data type, 
which indicates that they have to be hard coded in the kernel or get the 
parameter from the kernel constructor.

The advanced counter has more features than the chained counter, such as 
wrap mode, wrap value, count mode and so on. You can refer to them throught 
*Maxcompiler tutorial* 
