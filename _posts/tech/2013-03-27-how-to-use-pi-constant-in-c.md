---
layout: post
title: "How to use PI constant in C++"
comments: true
categories: tech
tags: [Trick,C/C++]
---

This is a variation from
[stackoverflow](http://stackoverflow.com/questions/1727881/how-to-use-the-pi-constant-in-c)
that describes how to use PI constant from library instead of manually
define it.

The PI constant is not defined in STL. Some people define the macro or
constant manually at the head of the file. However, there is a way to
introduce PI into your program from the `<cmath>` or `<math.h>` library. To
use it, just `#define _USE_MATH_DEFINES` followed by `#include <math.h>`,
and then `M_PI` and be used as PI.

{% highlight cpp %}

    #define _USE_MATH_DEFINES
    #include <math.h>

{% endhighlight %}

If you are curious about how it works, the quotation from math.h may give
you answer.

    /* Define _USE_MATH_DEFINES before including math.h to expose these macro
     * definitions for common math constants.  These are placed under an #ifdef
     * since these commonly-defined names are not part of the C/C++ standards.
     */

It may not work for all platform, however, it works on Linux GCC and visual
C++
