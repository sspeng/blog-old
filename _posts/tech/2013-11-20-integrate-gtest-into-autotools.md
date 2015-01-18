---
layout: post
title: "Integrate gtest (google test framework) into GNU Autotools Project"
comments: true
categories: tech
tags: []
---

## Introduction to Gtest and Autotools

[Gtest](https://code.google.com/p/googletest/) is a testing framework for
C++ on a variety of platform. It provides a rich set of assertion, various
options for running the test, and XML test report generation.

The *Autotool*, GNU building system, consists of *autoconf* and *automake*,
which aims to help the developers to generate different *Makefile*s on 
different platforms once the users execute *configure*. In addition, it can 
trace the file dependencies in a project, which releases the developers 
from updating the Makefiles.

`make check` will runs the test cases defined in the `check_PROGRAMS` and 
`TESTS` in *Makefile.am*. It will display a well structured statistic 
showing which test cases are passed and which are failed. The question here
is how to write the test cases using the third-party library, *gtest*, and 
run them with `make check`.

Writing the gtest (or other third party library) programs generally follow 
the following steps:

1. include the header files in your programs
2. add the folder where the headers resides to the preprocessor.
3. compile the program
4. link the program with external libraries.

So, the rest of this article shows how to implement the above steps in the 
Autotools.

## Integrate gtest into autotools project

In this part, I will show you show to program using external libraries in 
GNU autotools project. To be more specific, the *gtest* is used as an 
example.

### Prepare the gtest

You can download the gtest zip file manually or install it on a Ubuntu 
system via `sudo apt-get install libgtest-dev`. It will download the 
headers into `/usr/include/gtest`, and the sources into `/usr/src/gtest`. 
The headers can be included directly in your code, however, the 
corresponding library isn't built yet. So, you have to build the library 
manually.

{% highlight bash %}

    cd /usr/src/gtest
    cmake && make
{% endhighlight %}

*libgtest.a* will be generated in the folder */usr/src/gtest/*.

### Copy the headers to the current project

In your project, you can create a folder called `gtest`, and two subfolders
called `include` and `lib`, which host the headers and libraries 
respectively. Then copy the headers and libraries to the corresponding 
folder.

{% highlight bash %}

    cp -r /usr/include/gtest my-project-path/gtest/include/
    cp /usr/src/gtest/libgtest.a my-project-path/gtest/lib/
{% endhighlight %}


### Write a gtest program 

I create a `test` folder in the project's root folder, and now I create a 
gtest program, say `gtest.cxx`, in the `test` folder.

{% highlight cpp %}

    #include "gtest/gtest.h" // we will add the path to C preprocessor later

    int main(int argc, char **argv)
    {
      ::testing::InitGoogleTest(&argc, argv);

      return RUN_ALL_TESTS();
    }

{% endhighlight %}

Notice that, the header `gtest/gtest.h` is not at the `test` folder. 
Instead, it is at `my-project-path/gtest/include`. The reason that we can 
include `gtest/gtest.h` directly in the file is that we will add 
`my-project-path/gtest/include` to the path of the C preprocessor.

### Write Makefile.am

In the Makefile.am, we need to specific the following things:
1. the name of the program to be tested (run)
2. the name of the program to be compiled (not run)
3. the other flags

See the content of Makefile.am

{% highlight makefile %}

    LDADD =  ../gtest/lib/libgtest.a

    AM_CPPFLAGS = -I../gtest/include

    LIBS += -lpthread

    TESTS = gtest

    check_PROGRAMS = gtest

    AM_DEFAULT_SOURCE_EXT = .cxx

{% endhighlight %}

`LDADD` specific the path of gtest library and `AM_CPPFLAGS` specific the 
include path of gtest.

### Run
Now, you can run `make check` to pass the test.
