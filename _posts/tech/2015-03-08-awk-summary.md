---
layout: post
title: "AWK summary"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

* Table of Contents
{:toc}

# Positional variable
- positional variable: it is not a special variable, but a function 
triggered by the dollar sign, such as $1, $2.

- Variable `$0` refers to the entire line that AWK reads in.

You can modify positional variable. The following commands

{% highlight bash %}
$2 = "";
print;
{% endhighlight %}

delete the second field.

# AWK built-in variables

- This sections shows the built-in variables in AWK.

## FS - Input Field Separator Variable

- There are two ways to set the separator of the input file, by either 
  specifying the character after `-F` command line arguments or assigning 
  the character (or string) to built-in variable `FS` in the `BEGIN` 
  section in awk script.

- Only one character in permitted after the `-F` command line argument. 
However, a string could be assigned to `FS`.

- `FS` variable can be changed as many times as you want while reading a 
file.

- Only one separator in permitted in a line.

## OFS - Output Field Separator Variable

- The output field separator is pleaced when you put comma (,) between two 
fields in the `print` statement. The default output field separator is 
space.

- You can change the output field separator by changing the `OFS` variable.

## NF - Number of Fields Variable

- It is a good idea to test the number of fields when you executing your 
command.

## NR - Number of Records Variable

`NR` variable tells you the number of records current read, or the line 
number. 

## RS - Record Separator Variable
By default, the record separator is `'\n'`. You can set the record 
separator to change AWK's definition of a "line". 

If you set it to an empty string, then AWK will read the entire file into 
memory.

## ORS - Output Record Separator Variable
The default output record separator is a newline, like the input. This can 
be set to be a newline and carriage return, if you need to generate a text 
file for a non-UNIX system. 

{% highlight awk %}
!/bin/awk -f
 this filter adds a carriage return to all lines
 before the newline character
BEGIN { 
  ORS="\r\n"
}
{ print }
{% endhighlight %}

## FILENAME - Current Filename Variable

It tells you the name of file being read.

# Associative Arrays

An associative array is an array whose indexing is a string. It is similar 
to `std::map` in C++. 
