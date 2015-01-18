---
layout: post
title: "Take care of register in C"
description: ""
categories: tech
tags: [C/C++]
---


## Why we consider such subject
If you are considering some stuff that is related with the register in C, maybe 
you try to optimize for performance. Some variables can be stored in register 
instead of the RAM, in which case obtains the greatest speed. However, not all 
variable could be stored in the one register, as the range the variables that 
could be stored in the registers are limited by the size of the register, eg, A 
big struct could not fit in a register. You may post a question that what's the 
size of a register, and how to put the variables in the register? 

However, the C standard doesn't say anything about 
*register* . How about the register keyword? According to the C Standard, `the 
register keyword is merely a hint that access to a variable should be quick, 
it also means you can't take its address.` So to put a variable in the 
register, you can qualify the variable with the **register** keyword. You 
machine may *try* to store the variable into the register, but it is just a try, 
and a hint, not the force.

Although the standard doesn't say anything about the register, some people give 
some assumption and I think it is in use.

---------------------------------------

## Size of int == size of general-purpose register
Most people think that in practice, the size of the **int** data type is 
generally equal to the size of the CPU's general-purpose registers, since that 
is by far the most efficient option.

If an **int** was bigger than a register, then the machine needs more than one 
register to store the *data* data, so the simple arithmetic operations would 
require more than one instruction (combine the value in two register as one 
value), which would be costly. 

If they were smaller that a register, then loading and storing the value of a 
register would require the program to mask out the unused bits in order to 
overwrite other data (Maybe some align apply to it, without masking the unused 
bits, but need more space). That is why the *int* data type is typically more 
efficient that *short*.

## Size of int != size of general-purpose register
They are different kind of register with different sizes. What's important are 
the address registers, not the general-purpose ones. If the machine is 64-bit, 
then the address registers (or some combination of them) must be 64-bits, even 
if the general-purpose ones are 32-bit. In this case, the compiler may have to 
some extra work to actually compute 64-bit address using multiple general 
purpose register. In order to be efficient, the machine will use the 64-bit 
register instead of the 32-bit one. That's why the address register matters.

---------------------------------------

## More strictly explanation
Going strictly by the standard, there is no guarantee as to how big and how 
small an int is, much less any relation to the register size. What's more, some 
architectures have different size of register, that is, not all the register on 
the CPU are the same size, and the RAM isn't always accessed using just one 
register. With all that said, however, in most cases, *int* is the same size as 
the general-purpose register since the *int* data type is supposed to be the 
most commonly used basic type and that is what CPUs are optimized to operate on.

---------------------------------------

## Reflect in use
In a 32-bit machine, the size of *int*, *long* and *pointer* are generally 32 
bits. In which case, you can store either *int* and *long* data into register 
without considering the security and speed. 

However, In a 64-bit machine which still have all the 32-bit instructions, the 
*int* is 32-bit long, and *long* is 64-bit long, and the *pointer* is also 
64-bit long. If you suppose the size of the machine's general-purpose equals to 
the size of int, then pointer arithmetic need more instruction that generic 
arithmetic, which is not reasonable. So the size of the general-purpose register 
may be 64-bit long or the machine may have more than one kind of register. It 
has both 32-bit and 64-bit register.

On a *pure* 64-bit machine (usually some server), the size of int would likely 
be 64-bit too.

### Some un-secure operation
In C, you are likely to use *int* data type to iterate in the loop. For example
{% highlight cpp %}
register int i;
int max = 10;
for (i = 0; i < max; i++) {
    /* some stuff */
}
{% endhighlight %}

it is ok, because both *i* and *max* are of type *int*. However, you may write 
the following code in some case

{% highlight cpp %}
register int i;
for (i = 0; i < strlen(str); i++) {
    /* some stuff */
}
{% endhighlight %}

it is not secure, also, the compiler will give you a warning if you turn on the 
warning option of your compiler. The return type of `strlen` is *size_t*, this 
is generally the typedef of unsigned long

{% highlight cpp %}
typedef unsigned long size_t
{% endhighlight %}

According to the standard, `if either operand is unsigned long, the other shall 
be converted to unsigned long`. While comparing *int* and *unsigned long*, the 
variable *i* will converted to unsigned long, which may cause some mistakes. For 
example

    if strlen(str) == UINT_MAX, in the for loop, the variable i will keep 
    increasing from 0 to INT_MAX, then to (INT_MAX + 1), in which case, it is 
    out of the range of int. However, it is within the range of unsigned long, 
    so the condition in the for loop keep yield true until i == (UINT_MAX), in 
    my 32-bit machine, the hexidecimal value is 0XFFFFFFFF. Now the program will 
    jump out of the for loop. However, what is value of i now? It is -1.

    if you compare -1 with UINT_MAX, it will return true, because -1 would be 
    first converted to unsigned int, in which case, it is UINT_MAX (the hex 
    presentation of -1 is FFFFFFFF, which is the same as UINT_MAX)

### An potential solution
So, how to solve such problem? An easy solution is to declared i as *size_t* 
instead of *int*. In a 32-bit machine, it works quite well, gaining speed ans 
correct answer. However, on a 64-bit machine where int is 32-bit and size_t is 
64 bit, you may encounter some problems now. When you declare i as *size_t*, 
would i fits the register? Of course, the answer is: it depends, depending on 
the size of the register and the under implementation. 

Declaring i as *int*, you may gain speed but you are in a risk of not secure. On 
the other hand, declaring i as *size_t*, you can get the correct answer, but the 
variable may not fit in the register. An pure 64-bit machine solve all the 
problems however.

## Reference
- [Is there a relation between integer and register sizes?](http://stackoverflow.com/questions/1078768/is-there-a-relation-between-integer-and-register-sizes)
- [Signed/unsigned 
comparisons](http://stackoverflow.com/questions/5416414/signed-unsigned-comparisons) 
