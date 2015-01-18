---
layout: post
title: "Programming paradigm of FPGA"
comments: true
categories: tech
tags: [FPGA]
---

Programming by describing
===
The paradigm of coding in FPGA is different from that in general purpose
coding, such as C/C++. To be more precise, it is called describing rather
than coding. Imaging the data flowing through the chip, and you are
designing a filter in the chip that can make some operation on the data.

When you are designing the kernel with Java, the code that you write
doesn't have a directly impact to the configuration of FPGA. Instead, the
Maxcompiler will endeavor to figure out the meaning of the code, or the
logic of the code, and the compiler will then generate the hardware
description language for the chip. So, you can also be convinced that you
are communicating with the compiler, rather than the chip directly.

To have the whole array processed, the host program (c/c+) usually use the
for loop to iterate through each element: make action to the element, and
then iterate next one. Such a loop is replaced by the streaming concept of
FPGA. So you don't need to write loop in the FPGA kernel design. You only
need to design the filter filtering each element.

For example, to calculate the convolution:

{% highlight java %}

    float inStream[n∗n];
    float outStream[n∗n];

    // some works here

    for ( int y = 3; y < n−3; y++) {
      for ( int x = 3; x < n−3; x++) {
        outStream[y∗n+x] = (inStream[(y−3)∗n+x]−inStream[(y+3)∗n+x])∗(1.0/16)
          + (inStream[(y−2)*n+x]−inStream[(y+2)∗n+x])∗(1.0/8)
          + (inStream[(y−1)∗n+x]−inStream[(y+1)∗n+x])∗(1.0/4)
          + inStream[y∗n+x]∗(1.0/2);
      }
    }

{% endhighlight %}

you need to design the circuit calculating the operation of mulplication
and addition. The two for loop is for the host code. In the FPGA design,
the elements will come to the filter one by one.
