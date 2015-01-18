---
layout: post
title: "How to modify a file in a tarball"
categories: tech
tags: [Linux]
---

Sometimes you need to modify only one or several text files in a tarball
(whose file extension is .tar or .tar.gz) but not liking to extract all the
files in that tarball. Here presents ways to achieve that goal.

## Using vim directly

It is an amazing approach is the tarball is not quite large. You can open
tarball directly using `vim` editor, just like opening a folder using `vim`
editor, and then select the file you want to edit, save it, and quit.

#### pros
It is the most convenient way to edit a file in a tarball.

####cons
However, it takes long time if the tarball is very large. What's
more, if the file that you want to update is not a text file, but a binary
file, the `vim` approach doesn't work.

## Advance way

You may find that there is a `--update (-t)` switch for `tar` command. Yes,
that switch is used for update a file in a tarball. However, it doesn't
work for zip file, including .tar.gz file.

So, if you need to update a specified file in a .tar.gz file. You should
uncompressed it first.

{% highlight bash %}

    gzip -d example.tar.gz
{% endhighlight %}

Next, you need to find the file you want to update. Of course, you should
find the path of that file first.

{% highlight bash %}

    tar -tf example.tar
{% endhighlight %}

will list all the files in that tarball. When you find the specific file,
you can extract that file only with the file path to the extract
command.

{% highlight bash %}

    tar xvf example.tar path/to/file
{% endhighlight %}

Then you can modify the file. Do whatever you like.

When you finish the modification, you need to update the tar file.

{% highlight bash %}

    tar cvf example.tar path/to/file
{% endhighlight %}

The last step is to compress the tarball

{% highlight bash %}

    gzip example.tar
{% endhighlight %}

It will compress example.tar to example.tar.gz

## Common way

The most naive and common way is the extract the whole tarball. Update the
files you like and archive them again.
