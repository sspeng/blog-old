---
layout: post
title: "Avoid Duplication in const and non-const member function"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

Do you remember that in C++ STL, the container vector have the member function
at, which has two version of implementation. One for const and the other for
non-const. How to implement that without duplication?

{% highlight c++ %}
// the const version of the function
template <typename T>
const T &vector<T>::at(size_t index) const 
{
  return this->array[index];
}
{% endhighlight  %}

The above is the const version of the function. The non-const version just have
the same implementation except that it doesn’t have the const qualifier for
the function. Of course, the can copy the above code and remove the const
qualifier.

{% highlight c++ %}
// the non-const version of the function, but duplication
template <typename T>
T &vector<T>::at(size_t index)
{
  return this->array[index];
}
{% endhighlight  %}

However, there is a code duplication. I don’t want to over state the danger of
duplicate code. I just issue a version of non-const function which is based on
the const version without code duplication.

{% highlight c++ %}
// the non-const version of the function, without duplication
template <typename T>
T &vector<T>::at(size_t index)
{
  return const_cast<T &>(static_cast<const vector *>(this)->at(index));
}
{% endhighlight %}

In the non-const version, the this pointer of the function is a non-const this
pointer. To invoke the const version function, the this pointer should first be
converted to const this with the static_cast. The return type of the const
version function is const T &, which is not matched with the T &, so we still
need to do a conversion using the const_cast.
