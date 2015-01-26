---
layout: post
title: Coordinate of block and grid in CUDA
---

While lanching the kernel in CUDA programming, you should pass the
dimension of the grid and the dimension of the block to the triple angle,
such as

{% highlight cuda %}
dim3 dimBlock(2,3,4);
dim3 dimGrid(5,6,7);
kernel<<<dimGrid, dimBlock>>>(arg1, arg2);
{% endhighlight %}

You know that the first parameter of dim3 is `x`, and the second is `y` and the
last is `z`. And you can access each of them with the following global
variable.

{% highlight cuda %}
// variables accessing the dimBlock
blockDim.x = 2;
blockDim.y = 3;
blockDim.z = 4;

// variables accessing the dimGrid
gridDim.x = 5;
gridDim.y = 6;
gridDim.z = 7;
{% endhighlight %}

However, when you declare a cube of size row * col * height, and you want
to launch the kernel to perform some calculation of the cude, such as
scaling. Then you might want to divide your cude into blocks and grids,
with each thread dealing with each element. And the total grid size is
equal to or greater than the cude. So the result of blockDim.x * gridDim.x
should equals which dimension of your cude? The row, or col, or the height?

By practice, we see that X coordinate refers to the column of the grid or
matrix, the Y coordinate refers to the row of the grid or matrix, and the Z
coordinate refers to the height of the grid. So you can launch the kernel
like this

{% highlight cuda %}
// Assuming nCol can be divided by x
// nRow can be divided by x
// nHeight can be divided by z
dim3 dimBlock(2,3,4);
dim3 dimGrid(nCol / dimBlock.x, nRow / dimBlock.y, nHeight / dimBlock.z);
kernel<<<dimGrid, dimBlock>>>(arg1, arg2);
{% endhighlight %}

Because not to match X to row, and Y to column.
