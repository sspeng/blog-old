---
layout: post
title: "Constant expression and static storage duration in C"
description: ""
categories: tech
tags: [C/C++]
---


## What is constant expression
The constant expression in C is a bit different from that in C++. The keyword 
`const` only implies that the value is read only. It has nothing to do with 
the *constant* or *constant expression* in C.

Frome C99 standard $6.6.2, it said that

    A constant expression can be evaluated during translation rather than 
    runtime, and accordingly may be used in any place that a constant may be.

## Static storage duration variable's initializer
We need to use constant/constant expression in C in some place, one of which is 
that it is used to initialize static storage duration variable. See the 
following example:

{% highlight cpp %}

    const int a = 50; /* 50 is a constant */
    int b = a;        /* a is not a constant */
    /* some stuff */

{% endhighlight %}

Both a and b are global variables, and they have static storage duration. 
However, if you compile the code above, the compiler may complain the following 
error

    error: initializer element is not constant

All right, digit 50 is a constant, but the variable *a* is not a constant. If 
you insist on using *a* to represent value 50, and init *b* with *a*, you can 
define *a* as a macro instead of an expression.

{% highlight cpp %}

    #define a 50
    int b = a;
{% endhighlight %}

However, define *a* as a macro is a way to solve the above question, but doing 
this, you are also escaping to explain the error:

1. why b should be init with a constant?
2. why a is not an constant?
3. what are constants?

To answer the first question, we need to refer to the C99 standard again, from 
section 6.7.8

    All the expression in an initializer for an object that has static storage 
    duration shall be constant expression or string literals

Variable b is a global variable, thus has static storage duration, according to 
the standard, the initializer should be constant expression or string literals.

## The range of constant
To answer the second question, we need to know the range of *constant*. Once 
again, we need the refer back to the standard, the bible. From section 6.4.4

    constant: 
     integer-constant       (e.g. 1, 12L)
     floating-constant      (e.g. 1.14159, 0.7)
     enumeration-constant   (stuff in enums)
     character-constant     (e.g. 'a', '\0')

## The range of constant expression
What's more, according to section 6.6.2, `constant expression could be used in 
any place that a constant maybe`, so let's refer back to the standard to figure 
out the range of constant expression. See section 6.6.7

    More latitude is permitted for constant expressions in initializers. Such a 
    constant expression shall be, or evaluate to, one of the following:
     - an arithmetic constant expression,
     - a null pointer constant,
     - an address constant, or
     - an address constant for an object type plus or minus an integer constant 
     expression.

## The range of address constant
### NULL pointer
It is easy to understand that is arithmetic constant and the null pointer 
constant. But what is *address constant*? Is the following code valid?

{% highlight cpp %}

    int *pa = NULL;  /* NULL is a constant expression */
    int *pb = pa;    /* Is pb compliant */
{% endhighlight %}

If you compile the above code, you will get the same error because pa is not a 
constant nor a constant expression. 

### Static storage duration array
However, if pa is an array instead of a pointer, such as

{% highlight cpp %}

    int pa[10];     /* pa is an array instead of a pointer */
    int *pb = pa;   /* Is pb compliant */
{% endhighlight %}

The above code is absolutely valid and compliant. But why, in the former one, 
pa is a pointer, but in the later one, pa is an array. Of course pointer != 
array without needing to more explanation. In this subject, I just care about 
what is address constant? See section 6.6.9

    An address constant is a null pointer, a pointer to an lvalue designating 
    an object of static storage duration, or a pointer to a function 
    designator; 

If pa is an array, then it is `a pointer to an lvalue designating an object of 
static storage duration` because when we refer to the name of an array, it 
decay to an pointer points the first element of the array. The elements of the 
array has static storage duration as the array is global variable and it is 
allocated at the translation time, thus the second one is compliant.

### Static storage duration variable
What's more the following code is also valid

{% highlight cpp %}

    int a = 1;      /* a is a global variable */
    int *pa = &a;   /* ps is also a global var */
{% endhighlight %}

Variable a has static storage duration, pa is a pointer to an lvalue 
designating an object of static storage duration.

### Pointer to function designator
The following code is valid too
{% highlight cpp %}

    void foo();             /* function declaration */
    void (*pfnc)() = foo;   /* a pointer to function */
{% endhighlight %}

pfnc is a pointer to a function designator, pointing to function foo
