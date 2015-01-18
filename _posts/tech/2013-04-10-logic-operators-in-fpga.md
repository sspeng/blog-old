---
layout: post
title: "Logic operators in FPGA"
description: ""
categories: tech
tags: [FPGA]
---


This is an excerpt from *maxcompiler tutorial* at chapter 4.3:

    The logical NOT (!), logical AND (&&) and logical OR (||) operators are 
    not overloaded for streams: it is not possible to replicate the conditional 
    evaluation (or “short-circuiting”) semanticsin a dataflow Kernel. You 
    can directly replace these operators with the bit-wise AND & and bit-wise 
    OR | operators in many circumstances or use the ternary-if ?: operator 
    where conditional behavior is required.


The bit-wise operator's operand is 1-bit wide. So, if you use bit-wise 
operator directly to replace the logic operator, you should be sure that 
the operand is 1-bit wide. For example, if you need to translate the CPU 
code 

{% highlight cpp %}

    if (x < 3 && y < 3 && z < 3) {
      ret = 1;
    } else {
      ret = 0;
    }
{% endhighlight %}

to FPGA code, you can use

{% highlight cpp %}

    HWVar cond = ( (x < 3) & (y < 3) & (z < 3) );
    HWVar ret = cond ? 1 : 0;
{% endhighlight %}
