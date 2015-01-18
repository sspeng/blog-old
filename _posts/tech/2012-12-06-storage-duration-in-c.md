---
layout: post
title: "Storage duration in C"
description: ""
categories: tech
tags: [C/C++]
---


## Three Type of Storage Duration In C
For a specific variable, there are three type of storage duration (life time)
for  the variable. They are **automatic**, **static** and **register**. The
explanation of each of them is as below:

- **automatic** storage duration: the variable is allocated at the beginning of
the code block (after the '{' character), and is deallocated at the end of the
code block. All non-global variables have automatic storage duration, apart from
those declared as *static*, *extern*. For example

{% highlight cpp %}
void foo() {
    int        a;     /* automatic storage duration     */
    static int b = 1; /* non automatic storage duration */
    extern int c;     /* non automatic storage duration */

    /* something here */
}
{% endhighlight %}

- **static** storage duration: the variable is allocated when the program begins
and it is deallocated when the program ends. It means that such kind of
variables will be alive in the whole program's life. In addition, only one
instance of the variable exists. All global variables have static storage
duration, plus those declared with *static* and *extern*. For example

{% highlight cpp %}
int        ga;   /* global variable, static storage duration        */
static int gb;   /* global static variable, static storage duration */
extern int gc;   /* global extern variable, static storage duration */

void foo() {
    int        a;   /* automatic storage duration                             */
    static int b;   /* static variable in a function, static storage duration */
    extern int c;   /* extern variable in a function, static storage duration */

    /* something here */
}
{% endhighlight %}

- **register** storage duration: the keyword **register** is used to
define *local* variable that should be stored in a register instead of RAM. This
means that the variable has a maximum size that is equal to the register size
(usually the size of int) and *cannot* have the unary '&' operator apply to it as
the variable does not have a memory location (It is in the register).

{% highlight cpp %}
void foo() {
    int             a;   /* variable a is stored in RAM                         */
    register int    b;   /* b may be stored in register                         */
    register double c;   /* c is stored in RAM, as sizeof(double) > sizeof(int) */
}
{% endhighlight %}

Register should only be used for variable that require quick access, such as
counters. Defining **register** doesn't mean that the variable will be stored in
a register definitely. It is just a hint for the hardware to store it in a
register, depending on the hardware and implementation restrictions.

----------------------------------

## Storage Duration and Keywords
We introduce some keyword above, such as static, register, extern. However, the
keywords don't have a retrict relationship with the storage duration. What's
more, the keyword **static** and **extern** also relates to the linkages, the
inner linkage and external linkage. Here, we just decribe the storage duration.

- **static** keyword: if a variable is qualified with the static keyword, the
variable has static storage duration no matter the variable is a global variable
(all global variables have static storage duration) or a local variable.

- **extern** keyword: if a variable is qualified with a extern keyword, it
also has static storage duration no matter it is a global variable or local
variable. Only considering the storage duration but not the linkage, the
difference between the *static* and *extern* keywords is that

    - when a variable is qualified with a **static** keyword, it is the
    **definition** of the variable.

    - when a variable is qualified with a **extern** keyword, it is the
    **declaration** of the variable.

- **register** keyword: if a variable is qualified with a register keyword, it
indicates the register storage duration. The *register* keyword has just one
meaning. It has nothing to do with linkage.

----------------------------------

## Drawback Of C
The C programming language has some drawback in my opinion. One of such is the
multiple semantics of a keyword, such as the *static* and *extern* keyword we
just decribe above.

The keyword *register* has a clear semantic, but *static* and *extern* keyword
work for both storage duration and linkage. It may confuse the newbies to the
language.

----------------------------------

## [Reference]
1. [C Storage
   Classes](<http://www.lix.polytechnique.fr/~liberti/public/computing/prog/c/C/CONCEPT/storage_class.html>)

2. [Storage duration
   specifiers](http://en.cppreference.com/w/cpp/language/storage_duration)

3. [C - Storage
   Classes](<http://stackoverflow.com/questions/1078768/is-there-a-relation-between-integer-and-register-sizes>)
