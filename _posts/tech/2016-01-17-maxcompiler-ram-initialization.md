---
layout: post
title: "MaxCompiler: Seperate RAM initialization and update"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---
In *MaxCompiler* networking computing, it is essential to initialize a block a
fast memory (block memory) before receiving any packets. However, after
receiving some packets you also need to update this memory. As this is a common
case, a good idea is to create a base class for handling the initialization of
block memory and the derived class only need to focus on the update.
Otherwise, each class is responsible for both initialization and update.

The basic idea is to create a counter that counts from zero and stops at its
maximal value. For initialization, each cycle updates an element in the BRAM. If
the BRAM has a depth of `n`, the initialization operation works in the first `n`
cycles. In the code, the enable signal is `counter < n`.

{% highlight java %}
  DFEVar stopAtMaxCounter = control.count.makeCounter(
                  control.count.makeParams(32)
                  .withWrapMode(WrapMode.STOP_AT_MAX)
                  ) .getCount();
{% endhighlight %}

In order to create an interface of `write` for subclass that only cares about
update operation, the base class have to control when to initialize and when to
update. In the first `n` cycle, it is for initialization and update operation
afterwards. We implement this idea by using the `initEnable` signal as in the
following code snippets.

{% highlight java %}
  public void write(DFEVar address, DFEVar data, DFEVar enable) {
    /**
     * for initialization
     */
    DFEVar initAddr = stopAtMaxCounter.cast(addrType);
    DFEVar initEnable = stopAtMaxCounter < this.depth;

    DFEVar finalAddr = initEnable ? initAddr : address.cast(addrType);
    DFEVar finalData = initEnable ? initData : data;
    DFEVar finalEnable = initEnable ? initEnable : enable;
    super.write(finalAddr, finalData, finalEnable);
  }
{% endhighlight %}

You can find the code [here](https://github.com/conghui/maxlib/blob/master/Ram.java).
