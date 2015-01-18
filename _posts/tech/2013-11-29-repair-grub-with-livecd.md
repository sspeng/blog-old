---
layout: post
title: "Repair Grub with a LiveCD"
comments: true
categories: tech
tags: []
---

Sometimes your grub may corrupt, and this post shows how to repair the 
GRUB with a Ubuntu LiveCD.

## Mount the necessary partition before change root

When you start up your system through the LiveCD, your original Ubuntu 
partition is not mounted. You need to mount them before change root.

Support the root partition which contains the /boot partition is 
`/dev/sda5`, then you can mount it by

{% highlight bash %}

    sudo mount /dev/sda5 /mnt
{% endhighlight %}

What's more, you need to mount some additional virtual partitions, they 
are `/dev /sys /proc`. Mount them

{% highlight bash %}

    sudo mount --bind /dev/ /mnt/dev
    sudo mount --bind /sys /mnt/sys
    sudo mount --bind /proc /mnt/proc
{% endhighlight %}


## Change root and repair GRUB

Now you can change root by `sudo chroot /mnt` and issue the following 
command the repair the GRUB

{% highlight bash %}

    sudo grub-install --recheck /dev/sda
    sudo update-grub
{% endhighlight %}

Well, this command will isntall the grub in `/dev/sda`.

## Reference
1. [How to Repair, Restore, or Reinstall Grub 2 with a Ubuntu Live CD or 
   USB](http://howtoubuntu.org/how-to-repair-restore-reinstall-grub-2-with-a-ubuntu-live-cd#.Upqj63UW09B)
