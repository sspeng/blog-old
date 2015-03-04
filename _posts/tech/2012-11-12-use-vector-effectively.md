---
layout: post
title: "Use vector effectively"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Covering the source code of std::vector today makes me more comprehansive with
std::vector whiling using it and while when to use it.

Vector is the simplest container that is eaiest to implement. The storage is
allocated from the heap, that is a raw memory that would be initialized futher
to store some objects. The most important part of the vector, in my opinion, is
the set of pointers, start, finish, end_of_storage. That is the only handle to
modified the array in the heap. They control the size of the vector, the
capacity of the vector and determine if another allocation of memory should be
performed. What’s more, swaping two vector just swap the set of the pointers
previously described.

The best property that vector has is random access. You can just adcance the
pointer and then dereference it. However, the major drawback of vector is the
copy operation, especially for the large objects. In my conclusion, the copy
operation will perfom in thefollowing situation:

- the capacity is full.  

- reserve() function is called for more capacitywhiling some elements are
already in the array.  

- insert some elements not from the end of the array.  

- erase some elements not from the end of thearray.

- when the operator = is called.  The copy operation means that the constructor
and destructor for the elements have to be called lots of times, in addition,
some times we also have to allocate memory from the heap and release the
preallocated memory to the heap, which is also time costing.

So, the most effective and efficient way to use vector is to use it just like a
wrapper of dynamic array, giving the specific capacity and only append
elements. In this way, the capacity won’t change in the future, and no copy
operation will be performed.

If the copy operation is unavoidable, then use the pointer to the objects that
is not POD types, instead of storing the object in the vector. copying the POD
type is much faster than copy the fully defined object.
