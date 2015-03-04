---
layout: post
title: "Stream Boundary Checking Using Counter"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---
In maxcompiler coding, while accessing the elements in a stream in terms of 
stream offset, the value of the element that is out-of-bound is undefined. 
For example, when accessing the first element, and you want to access the 
offset of -1, the the value of that element is undefined.

Accessing the elements in the stream that is 
out-of-bound in terms of stream offset is undefined. So, you may wonder how 
to determine the current position of the element.

One of the ways is using the counter. For example, for an array, set a
counter for the array; increase the counter every cycle; then when the
value of counter is zero (it is the first cycle),  the first element
is accessed.
