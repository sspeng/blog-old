---
layout: post
title: "Handle multi dimension array in continuous ways"
description: ""
categories: tech
tags: [Trick,C/C++]
---


Array is easy for access and thus widely used in programs. You can create 
arrays statically and dynamically. Static arrays are easy to create and 
easy to access, and they are stored in a continuous ways in the memory. However, 
how about the two dimensional array if you don't know the size of the array 
in advance?

### A general way to create two-dimensional array

Nearly every book talking about C/C++ or the algorithms will tell you how 
to create a 2D array dynamically. They may explain that such as:

{% highlight cpp %}

    size_t nCol = 32; // the # of column of the array
    size_t nRow = 32; // the # of row of the array

    int **array = new int*[row]; // array of pointer, pointing to each row
    for (size_t row = 0; row < nRow; row++) {
        array[i] = new int[nCol];  // create array for each row
    }

{% endhighlight %}

In this way, you can access the (i, j)th element just use the handy index 
access such as `array[i][j]`, it is equivalent to `(*(array + i))[j]`, and 
it is also equivalent to `*((*(array + i)) + j)`. So we can make a small 
conclusion:

        array[i][j] == (*(array + i))[j] == *((*(array + i)) + j)

You can see that, the so-called `array indexing` is just `pointer 
dereference`. What's more, the elements of the array are stored in the 
different part of the memory, just like
    ![two-dimensional array memory image](/images/array-2d.png)

As what is in your vision, the content of the array is not continuous, it 
is not portable if you want to transfer the content of the array to another 
function by justing using a pointer-to-t pointer. 

### Why you need a continuous-lied memory array

If you ever have any experience about the CUDA programming, that you are 
familiar with the data transferring between the CPU(host) and the 
GPU(device). You may invoke the `cudaMemcpy` function and pass the pointer 
to the data that you wish to transfer. But if you store your previously 
allocated two-dimensional array using the general-way (that is, create a 
array of pointer and than assign an array to each pointer), you can't 
violently convert the pointer to he required type and pass it to the 
function, because, again, the content is not continuous. The only ways to 
solve such question is to copy the elements in the two-dimension array into 
a newly allocated one-dimension array, one by one, and then pass the array 
to the function.

However, you may also notice that the overhead of copy the whole array in 
order to just call the function. You may wonder if there is a elegant way 
to use a 2-dimension or even 3-dimension array in continuous in the memory.
Of course, the answer is Yes.

### Use static arrays if you know the size in advance

The static array (stored in the stack, rather than the heap) is stored in a 
continuous way. For example, `int A[2][3]` implies that `A` is the address 
of an array of 6 elements continuously. First, the first row, which 
containing 3 elements, and then, the second row, which also contains 3 
elements.

If you need a pointer pointing to the beginning of the array and the 
pointer is just a pointer-to-T pointer, not a pointer to an array, you can 
cast the pointer of the array, or just use the address of the first element 
of the array. For example:

{% highlight cpp %}

    int a[3][4];
    int *dev_a;
    size_t nBytes = 3 * 4 * sizeof *a;
    cudaMalloc(&dev_a, nBytes);
    cudaMemcpy(dev_a, &a[0][0], nBytes, cudaMemcpyHostToDevice);
{% endhighlight %}

The same approach is also applied to the three-dimension array that is 
defined in the stack.

### What if the dynamic array ? Just use one dimensional array

So, you may wonder what if I want to create a dynamic array when I don't 
know the size of the array in advance. The first approach is to just use 
the linear array, and access the element of the array manually by a 
function. For example, to manipulate an array of size 3x4, you can do it in 
the following way.

{% highlight cpp %}

    size_t nRow = 3;
    size_t nCol = 4;
    int *A = new int[nRow * nCol];
{% endhighlight %}

The above code is about how to create the 2D array. But how to access the 
element in row i and row j. The answer is, define a function to access the 
element in a specific position.

{% highlight cpp %}

    inline size_t at(size_t row, size_t col, size_t nCol)
    {
       return row * nCol + col;
    }
{% endhighlight %}

The function `at` will just return the index of the linear array at 
position (i,j) of the virtual 2D array. To get the value of the (i,j) 
element, you can use the code like this.

{% highlight cpp %}

    // c[i][j] = a[i][j] + b[i][j];
    c[at(i,j,nCol)] = a[at(i,j,nCol)] + b[at(i,j,nCol)];
{% endhighlight %}

With such a approach, you can pass the array to any routine that require to 
receive a pointer to void, and the above code for CUDA is perfectly fine.

### Use the same approach for 3-dimension array

What's more, you can use the same approach for manipulate the 
three-dimension array. The total element of the array is `column x row x 
height`. And what you also need to write a correct `at` function to access 
the element. Here is a code for example for the array creation.

{% highlight cpp %}

    size_t col    = 5;
    size_t row    = 4;
    size_t height = 3;
    int *cude = new int[col * row * height];

{% endhighlight %}

And here is a code example for the function `at`

{% highlight cpp %}

    inline size_t at(size_t height, size_t row, size_t col,
                     size_t nRow, size_t nCol)
    {
        return height * nRow * nCol + row * nCol + col;
    }
{% endhighlight %}

Now you can access the array in a handy ways like this `c[at(i, j, k, nRow, nCol)];`

If you think that there are too element to pass to the function, you can 
encapsulate the array in a class and so the `nCol` and `nRow` will be the 
data member of the class, so you just need to pass the index of the element 
to the function, which is somewhat more elegant.
