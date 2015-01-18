---
layout: post
title: "List the largest folder in Linux"
comments: true
categories: tech
tags: [Linux]
---

Linux has a rich set of command that can manipulate and access files. The 
`du` command is used to refer the disk usage of files or folders. This post 
introduce how to list the 10 largest folders in the current folder.

{% highlight bash %}

    du -sh *

    4.0K  Desktop
    67M Documents
    1.6G  Downloads
    374M  Dropbox
    2.9G  Mail
    1.2M  Music
    15M Pictures
    4.0K  TO-DO.mkd
    4.0K  Ubuntu One
    4.0K  Videos
    11G VirtualBox VMs
    136M  vroot
    26M workspace
{% endhighlight %}

The above command will list the disk usage of all the files/folders in a human 
readable format, such as G,M,K. However, It is not intuitive to recognize 
their rank.

{% highlight bash %}

    du -sm *


    1 Desktop
    67  Documents
    1605  Downloads
    374 Dropbox
    2871  Mail
    2 Music
    15  Pictures
    1 TO-DO.mkd
    1 Ubuntu One
    1 Videos
    10779 VirtualBox VMs
    136 vroot
    26  workspace
{% endhighlight %}

The above command will list the disk usage of all the folders/files in size 
of MB. Now it is easy to recognize which are the largest. What's more, if 
there are large number of folders, and the output is a long list. You can 
pipe the above result to `sort -nr` command to sort them in 
numeric ascending/descending order.

{% highlight bash %}

    du -sm * | sort -rn

    10779 VirtualBox VMs
    2871  Mail
    1605  Downloads
    374 Dropbox
    136 vroot
    67  Documents
    26  workspace
    15  Pictures
    2 Music
    1 Videos
    1 Ubuntu One
    1 TO-DO.mkd
    1 Desktop
{% endhighlight %}

If you just need to retrieve the first 5 item that is the largest, you can 
use the `head` command to achieve the task.
