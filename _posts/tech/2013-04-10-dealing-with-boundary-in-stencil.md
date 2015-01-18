---
layout: post
title: "Dealing with boundary in stencil"
description: ""
categories: tech
tags: [FPGA]
---


How to deal with the boundary in stencil. Detailed in code.

As stated in [stencil code](http://en.wikipedia.org/wiki/Stencil_code), the 
boundary value are left unchanged in most cases. But in same case, those 
need to be adjusted during the course of the computation.

## Unchanged the boundary
If we left the boundary value unchanged, only the cells in the middle of the grid is 
computed as the output. 

### Implementation on CPU

If we implement it with CPU, using for loop the access the elements, we can 
jump directly in the middle of the grid. For example, if the boundary is 
the outside three layer of a 3D grid, then we can calculate the stencil as 
follows:

{% highlight cpp %}

    for (iz = 3; iz + 3 < nz; iz++) {
      for (iy = 3; iy + 3 < ny; iy++) {
        for (ix = 3; ix + 3 < nx; ix++) {
          out[iz][iy][ix] = stencil(in, iz, iy, ix);
        }
      }
    }
{% endhighlight %}

However, the `out` array cannot be treated as the final result, because 
`out` doesn't contain the value of boundary. How can we identify the 
boundary? For a 3D grid, there are six faces as the boundary. We process 
each using a for loop.

{% highlight cpp %}

    // front z and back z
    for (iz = 0; iz < 3; iz++) {
      for (iy = 0; iy < ny; iy++) {
        for(ix = 0; ix < nx; ix++) {
          out[iz][iy][ix] = in[iz][iy][ix];
          out[nz-1-iz][iy][ix] = in[nz-1-iz][iy][ix];
        }
      }
    }

    // front y and back y
    for (iy = 0; iy < 3; iy++) {
      for (iz = 0; iz < nz; iz++) {
        for (ix = 0; ix < nx; ix++) {
          out[iz][iy][ix] = in[iz][iy][ix];
          out[iz][ny-1-iy][ix] = in[iz][ny-1-iy][ix];
        }
      }
    }

    // front x and back x
    for (ix = 0; ix < 3; ix++) {
      for (iz = 0; iz < nz; iz++) {
        for (iy = 0; iy < ny; iy++) {
          out[iz][iy][ix] = in[iz][iy][ix];
          out[iz][iy][nx-1-ix] = in[iz][iy][nx-1-ix];
        }
      }
    }

{% endhighlight %}

You may find it a little tedious. Is there any elegant code for the same 
task? Yes, there is. We can iterate the whole grid and have a `if/else` 
branch for each element, testing whether it is in the middle of the grid of 
at the boundary. This version of code is generally considered slower than 
the previous one, but the code is much more elegant.

{% highlight cpp %}

    for (iz = 0; iz < nz; iz++) {
      for (iy = 0; iy < ny; iy++) {
        for (ix = 0; ix < nx; ix++) {
          if (iz >= 3 && iz < nx - 3 &&
              iy >= 3 && iy < ny - 3 &&
              ix >= 3 && ix < nx - 3) {
            // in the middle of the grid
            out[iz][iy][ix] = stencil(in, iz, iy, ix);
          } else {
            // at the boundary
            out[iz][iy][ix] = in[iz][iy][ix];
          }
        }
      }
    }
{% endhighlight %}

### Implementation on FPGA

The above code can be implemented on FPGA. We use chained counter to mimic 
the for loop, test the whether the index is in the middle of the grid or at 
the boundary. The logic AND (&&) operator is not overloaded for streams, in 
this case, we use bit-wise operator (&) to replace it. 

{% highlight cpp %}

    // use chained counter to mimic the for loop
    CounterChain chain = control.count.makeCounterChain();
    HWVar iz = chain.addCounter(inz, 1);
    HWVar iy = chain.addCounter(iny, 1);
    HWVar ix = chain.addCounter(inx, 1);

    iz = iz.cast(uint32_t);
    iy = iy.cast(uint32_t);
    ix = ix.cast(uint32_t);


    HWVar in_middle = ((iz >=3) & (iz < inz - 3) &
                       (iy >=3) & (iy < iny - 3) &
                       (ix >=3) & (ix < inx - 3));

    HWVar tmp =
        (stream.offset(Pt, -3) + stream.offset(Pt, 3)) * w3 +
        (stream.offset(Pt, -2) + stream.offset(Pt, 2)) * w2 +
        (stream.offset(Pt, -1) + stream.offset(Pt, 1)) * w1 +

        (stream.offset(Pt, -3*nx) + stream.offset(Pt, 3*nx)) * w3 +
        (stream.offset(Pt, -2*nx) + stream.offset(Pt, 2*nx)) * w2 +
        (stream.offset(Pt, -1*nx) + stream.offset(Pt, 1*nx)) * w1 +

        (stream.offset(Pt, -3*nxy) + stream.offset(Pt, 3*nxy)) * w3 +
        (stream.offset(Pt, -2*nxy) + stream.offset(Pt, 2*nxy)) * w2 +
        (stream.offset(Pt, -1*nxy) + stream.offset(Pt, 1*nxy)) * w1 +

        (Pt * w0) * 3;

    HWVar PtStencil = in_middle ? tmp : Pt;
{% endhighlight %}

## Adjust the boundary value
If we need to adjust the boundary value, which is difficult than the 
unchanged version, we need to identify the boundary and adjust it.

I will write the topic in another separate post.

