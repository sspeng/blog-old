---
layout: post
title: "Latex: Create An Empty Page"
comments: true
categories: tech
tags: [Latex]
---
Sometime it is necessary to create an empty page in Latex. However, 
command `\newpage` doesn't really work sometimes. It is necessary to use a 
trick to create an really empty page in Latex. The following code does the 
job:

{% highlight tex %}

    \newpage
    \thispagestyle{empty}
    \mbox{}
{% endhighlight %}

`\mbox{}` will create an empty box which contains nothing in this example, 
thus will ensure the existence of an empty page.

The usage of `\thispagestyle` is `\thispagestyle{option}`. The option can be:

- plain: Just a plain page number.
- empty: Produces empty heads and feet - no page numbers.
- headings: Puts running headings on each page. The document style 
  specifies what goes in the headings.
- myheadings: You specify what is to go in the heading with the `\markboth` 
  or the `\markright` commands.

The usage of `\thispagestyle` comes from [Hypertext Help with 
LaTeX](http://www.giss.nasa.gov/tools/latex/ltx-tar.html).

#### Reference
[Creat an empty page in 
Latex](http://nw360.blogspot.com/2007/10/creat-empty-page-in-latex.html)
