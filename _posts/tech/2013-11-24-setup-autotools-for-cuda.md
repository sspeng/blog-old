---
layout: post
title: "Setup Autotools for CUDA programming"
comments: true
categories: tech
tags: []
---

## Autotools works greatly for general C/C++ projects
The **GNU build system**, also known as the **Autotools**, is the suite of 
programming tools desinged to make source code package portable to many 
Unix-like system.

One great feature of it is that it can generate fancy *Makefile* 
automatically by specifying the source files you need to compile. By 
default, it only works for C/C++ and Fortran programs. Chances are that I 
need to do some programming in CUDA, thus writing the file end with .cu 
suffix and invoking `nvcc` to compile the _*.cu_ files.

So the question is how to invoke `nvcc` to compile the _*.cu_ files 
automatically by configuring the autotools.

## Invoke nvcc for all files
Generally, you are writing a C/C++ project as well as CUDA. The `nvcc` 
compiler can also compile the general _*.c_ and _*.cpp_ files. So, you can 
set `nvcc` as the default compiler for the C/C++ source files. The most 
convenient way to set variable *CC* and *CXX* to `nvcc` is setting them 
while configuring the project.

{% highlight bash %}

    ./configure CC=nvcc CXX=nvcc
{% endhighlight %}

or you can use `nvcc` by default in file *configure.ac*.

{% highlight bash %}

    # set nvcc in configure.ac
    AC_PROG_CC([nvcc])
    AC_PROG_CXX([nvcc])
{% endhighlight %}

After that, `nvcc` will be the compiler to compile all the C/C++ source 
files. However, the *C/C++ source files* here means all files that can 
be recognized be the system as C/C++ sources. By default, the files are 
suffixed with cpp, cxx, cc, c, but not cu.

So you have to create a rule to compile the *.cu files. To achieve that, 
the following configration is added to *Makefile.am*.

{% highlight bash %}
    
    # the cuda compiler
    NVCC = nvcc

    # root path of cuda toolkits 
    CUDA_ROOT_DIR = /usr/local/cuda-5.0

    # the preprocessing flags passed to the compiler
    NVCC_CPPFLAGS = -I$(CUDA_ROOT_DIR)/include \
                    -I$(CUDA_ROOT_DIR)/samples/common/inc

    # compiling flags
    NVCC_CXXFLAGS = -O2 -g -G -dc \
                    -gencode arch=compute_35,code=sm_35

    # the linking flags
    NVCC_LINKFLAGS = -gencode arch=compute_35,code=sm_35 \
                     -L/usr/local/cuda-5.0/lib64 -lcudart

    bin_PROGRAMS = main
    main_SOURCES = main.cu
    main_LDFLAGS = $(NVCC_LINKFLAGS)

    # the rule that can recognize *.cu files
    # and compile the *.cu files to *.o files
    .cu.o : ; $(NVCC) $(NVCC_CPPFLAGS) $(NVCC_CXXFLAGS) -c -o $@ $<

{% endhighlight %}

The Makefile.am above is a sample that can be used to compile the program 
main.cu in the current folder.

That's all.

## FAQ
There are several questions that you may ask.

### Why do we need to set nvcc as default compiler

Actually, you don't need to set `nvcc` as the default compiler, because the
rule defined will use `nvcc` to compile the cuda source files.

However, in the linking stage, we have to use `nvcc` other than `g++` as 
the linker. So, for simplicity, you can set `nvcc` as the default compiler 
which makes `nvcc` as the default linker.

So, if you can only specify `nvcc` as the linker of the program, you don't 
have to set `nvcc` as the default compiler.
