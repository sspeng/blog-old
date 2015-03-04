---
layout: post
title: "Add new filetype in vim"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

### File Type In Vim

Vim can detect different kinds of file type when you edit a new file, it will
set the syntax hightlighting and set some option. Have you been ever curious
about how it works?

To enable file type dection in VIM, you should first use this command in your
vimrc:

{% highlight vim %}
filetype on 
{% endhighlight %}

#### Action of 'filetype on'

After using this command, every time you read a buffer or read a buffer for a
newly edit file (that is, edit a new file or switch from one buffer to another
buffer), VIM will try to recognize the type of the file and set the filetype
option, this will trigger the filetype event, including: 

1. set the syntax highlighting 
2. set the extra option for the file type.

The filetype on command will load `$VIMRUNTIME/filetype.vim` file. The file is a
Vim script that defines autocommands for the `BufNewFile` and `BufRead` events. If
the file type is not found by the name, the file `$VIMRUNTIME/scripts.vim` is
used to detect it from the content of the file.

### Add My Own File Type

If your file type is not detected, or if you want override the default
filetype, for example, the default filetype defined in `$VIMRUNTIME/filetype.vim`
of `.pro` is IDLANG, I want to override it and make it the default filetype of
QMAKE, The following method could achieve it.

It is not a good idea to modify the `$VIMRUNTIME/filetype.vim`, as it is not
portable when you move your vim file to another machine. You'd better have some
modification is your `~/.vim` directory.

create a directory name `ftdetect` in ~/.vim if it doesn't exist.  create a file
name `pro.vim` in `~/.vim/ftdetect/` if the file type you want to add is pro, you
can change it to another name.  populate the `~/.vim/ftdetect/pro.vim` with the
the following line:

{% highlight vim %}
    autocmd BufRead,BufNewFile *.pro set filetype=qmake 
{% endhighlight %}

Done!

### Relation Between File Type And Syntax

Usually, you want to have a syntax for your new added file type. In this case,
I set the `*.pro` file with my own syntax file `~/.vim/syntax/qmake.vim`.

In the obove example, I have set the file type of `*.pro` file to qmake. So when
the BufRead or BufNewFile event occurs, it will try to search a file
`~/.vim/syntax/qmake.vim`. If the file doesn't exist, your syntax wouldn't works.
So you should doble check the name of the syntax file and the value thefiletype
variable, make them the same.
