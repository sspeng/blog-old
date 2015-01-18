---
layout: post
title: "Latex: Table of Contents with Chapter"
comments: true
categories: tech
tags: [Latex]
---

Currently, the default displaying of table of contents in Latex doesn't
include the *Chapter* words. What if I want to include such kind of words
in table of contents in Latex so that the list is change from

    1 Introduction
      1.1 First Section
      1.2 Second Section
    2 Section Chapter
      2.1 First Section
      2.2 Second Section

to

    Chapter 1 Introduction
      1.1 First Section
      1.2 Second Section
    Chapter 2 Section Chapter
      2.1 First Section
      2.2 Second Section

With `tocloft` one can use `\cftchappresnum` to put something before the
number; but we have also to reserve enough space. I defer the space
setting when the text font is already established.

{% highlight tex %}

    \documentclass[a4paper]{book}
    %% add the following three lines in your code
    \usepackage{tocloft,calc}
    \renewcommand{\cftchappresnum}{Chapter }
    \AtBeginDocument{\addtolength\cftchapnumwidth{\widthof{\bfseries Chapter }}}

    \begin{document}
    \tableofcontents

    \chapter{Introduction}

    \chapter{Second shapter}
    \section{First section}
    \section{Second section}
    \section{Last section}

    \chapter{Last shapter}
    \section{First section}
    \section{Second section}
    \section{Last section}

    \end{document}
{% endhighlight %}

With the code above, you can generate the table of contents with chapter,
which is shown below.
![table of contents with 
chapter](/images/table-of-contents-with-chapter.png)

####Reference
[Table of Contents with Chapter](http://tex.stackexchange.com/questions/39153/table-of-contents-with-chapter)
