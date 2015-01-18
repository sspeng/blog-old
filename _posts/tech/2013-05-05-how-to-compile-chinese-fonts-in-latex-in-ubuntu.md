---
layout: post
title: "How to compile Chinese fonts in Latex in Ubuntu"
comments: true
categories: tech
tags: [Linux]
---

Install texlive manually
===
No matter which distribution you are using, I suggest you install the 
*texlive* package manually, without using the `apt-get install` command in 
Ubuntu or `emerge` command in Gentoo. Why? Some tools may not install while 
using the command line installtion because you don't know the tools you 
need to install belongs to which package.

Preparing Chinese fonts
===
Chinese fonts is necessary while compiling the tex file. For simplicity, I 
keep a backup of those fonts in the current 
[folder](https://www.dropbox.com/sh/blkfxli3kb0i7ny/_8PYuz6i0c/fonts). You 
can download all the files into folder named *fonts* and copy the whole 
directory (including the folder) into ~/.local/share/ or make a symlink to 
it.

{% highlight bash %}

    cp -a fonts ~/.local/share/
    fc-cache
    fc-list :lang=zh-cn
{% endhighlight %}

You can see a list of Chinese fonts after executing the last command.

Replace the default Chinese fonts configuration files
===
The default Chinese fonts configuration file may not use the same font 
(also, same name) to our previous copied fonts. So we need to modify these 
files so that the names of the fonts in the configuration files are the 
same with the name of our previously copied fonts.

For simplicity, I also have a backup of the configuration file, 
[ctex-xecjk-adobefonts.def](https://www.dropbox.com/sh/blkfxli3kb0i7ny/KHZ38-PpIF/ctex-xecjk-adobefonts.def),
[ctex-xecjk-winfonts.def](https://www.dropbox.com/sh/blkfxli3kb0i7ny/EBaIuHI94O/ctex-xecjk-winfonts.def).
You just replace them with ours.

For example, I installed [texlive 
2012](ftp://tug.org/texlive/Images/texlive2012-20120701.iso) in the default directory, that is 
`/usr/local/texlive/`. So the folder that contains the files that I need to 
replace is  in 
`/usr/local/texlive/2012/texmf-dist/tex/latex/ctex/fontset/`. You can 
simply copy the `ctex-xecjk-adobefonts.def` and `ctex-xecjk-winfonts.def` 
in current folder to that directory.

{% highlight bash %}

    cp ctex-xecjk-adobefonts.def ctex-xecjk-winfonts.def \
    /usr/local/texlive/2012/texmf-dist/tex/latex/ctex/fontset/
{% endhighlight %}

Have a try for it
===
The above step is enough to support Chinese in Latex. To have a try, 
compile the following code using command `xelatex` to generate the pdf

{% highlight tex %}

    \documentclass{ctexart}
    \begin{document}
    \section {这是黑体, 正常}

    你好，TeX Live 2009！,这是宋体

    \emph{你好，TeX Live 2009！这是楷书}

    \end{document}
{% endhighlight %}


Is it all right?

In the above example, the latex will choose the Windows fonts (by default), 
if you prefer Adobe fonts, just add the font option `adobefonts` to `documentclass`:

{% highlight tex %}

    \documentclass[adobefonts]{ctexart}
    \begin{document}
    \section {这是黑体, 正常}

    你好，TeX Live 2009！,这是宋体

    \emph{你好，TeX Live 2009！这是楷书}

    \end{document}
{% endhighlight %}

Download Links
===
- Chinese fonts 
  ([download](https://www.dropbox.com/sh/blkfxli3kb0i7ny/_8PYuz6i0c/fonts))
- Texlive 2012 
  ([download](ftp://tug.org/texlive/Images/texlive2012-20120701.iso))
- ctex-xecjk-adobefonts.def 
  ([download](https://www.dropbox.com/sh/blkfxli3kb0i7ny/KHZ38-PpIF/ctex-xecjk-adobefonts.def))
- ctex-xecjk-winfonts.def 
  ([download](https://www.dropbox.com/sh/blkfxli3kb0i7ny/EBaIuHI94O/ctex-xecjk-winfonts.def))

