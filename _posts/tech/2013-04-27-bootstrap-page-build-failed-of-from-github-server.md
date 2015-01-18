---
layout: post
title: "Bootstrap: Page build failed from github server"
description: ""
categories: tech
tags: [Bootstrap]
---


I am obstructed for the message from the email that github send to me.

{% highlight bash %}

    The page build failed with the following error:

    page build failed

    For information on troubleshooting Jekyll see
    https://help.github.com/articles/using-jekyll-with-pages#troubleshooting
    If you have any questions please contact GitHub Support.

    support@github.com
    https://github.com/contact
{% endhighlight %}

I keep track of the output of the `jekyll --safe --no-lsi --server`,
solving all the ERRORS. However, I still received the same email when I
pushed the non-error version.

I try `vimdiff` to compare my new post and previous post and found that my
new post miss one line `` where it exists in my old
post. When I add it to my new post, the github server update the blog
properly.

I don't understand what's the reason behind it, and what is the function of
`JB`. If you know the answer, please shout to me through
<heconghui@gmail.com>
