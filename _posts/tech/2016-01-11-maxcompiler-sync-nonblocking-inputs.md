---
layout: post
title: "MaxCompiler: synchronize nonblocking inputs"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

In MaxCompiler the nonblocking input is good in networking packets processing
because you never know when the next packet comes and what the length of next
packet is. The nonblocking input, compared with normal blocking input,
`io.input`, will not stall the kernel even if there is no valid input data.
However, in blocking input, say `io.input` will stall the kernel if the kernel
request input in this cycle, but without receiving input data. The nonblocking
input keeps getting input. However, not all the times can the input get valid
data, so there is a flag called `valid` used to identifying whether the current
64 bits of data is valid or not. In processing, you can use `valid` flag to
capture the real input data. So, it is a good design.

Then the question is, can we got the valid data at the same time for 2
nonblocking inputs? To be more specifically, can we get the true `sof` flags at
the same cycle for 2 inputs? I have though about this question for a long time
but now I think the answer is NO because you never know when the packets would
come.

However, you can always get the valid data from one non-blocking input because
that is what the non-blocking input aims to do.  What's more, the normal
blocking input will only accept the valid data whenever it read it. So,
combining one non-blocking input and multiple normal input gives us an
opportunity to synchronize multiple inputs.

In the following code snipppets, you can get valid inputA and inputB at the
cycle when `sof` evaluates to true. Of course, in this example, you can only got
the valid data when `sof` is true, but you can change the condition for the
controlled input to accept input in multiple cycles (using counter what reset
when `sof` evaluates to true and increase when `valid` evaluates to true).

{% highlight java %}
DFEVar inputA = io.input("inputA", dfeUInt(32), sof & valid));
DFEVar inputB = io.input("inputB", dfeUint(32), sof & valid));
{% endhighlight %}

