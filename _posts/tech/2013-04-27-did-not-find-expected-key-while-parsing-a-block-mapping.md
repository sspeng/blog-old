---
layout: post
title: "Did not find expected key while parsing a block mapping"
description: ""
categories: tech
tags: [Bootstrap]
---


There is another subtle error while running the `jekyll --no-auto
--server`. The terminal gives me such kind of error that I havn't met
before.

{% highlight bash %}

    Configuration from /home/rice/workspace/conghui.github.com/_config.yml
    Building site: /home/rice/workspace/conghui.github.com ->
    /home/rice/workspace/conghui.github.com/_site

    ERROR: YOUR SITE COULD NOT BE BUILT:
    ------------------------------------
    (<unknown>): did not find expected key while parsing a block mapping at
                 line 2 column 1 in
                 /home/rice/workspace/conghui.github.com/_posts/2013-04-27-bootstrap-page-build-failed-of-from-github-server.md
{% endhighlight %}

However, the first several line of
*2013-04-27-bootstrap-page-build-failed-of-from-github-server.md* is

{% highlight ruby %}

    ---
    layout: post
    title: "Bootstrap: "Page build failed" from github server"
    description: ""
    categories: tech
    tags: [Bootstrap]
    ---

{% endhighlight %}

It is just an template that is automatically generated by `rake` command.
What's wrong with it? Then I give a magic try. I add a **space** at `line 2
column 1`, so the modified text just likes

{% highlight ruby %}

    ---
    layout: post
     title: "Bootstrap: "Page build failed" from github server" # a space in the front
    description: ""
    categories: tech
    tags: [Bootstrap]
    ---

{% endhighlight %}

Then rerun the `jekyll --no-auto --server`. It works this time. Do you know
the reason behind it?

## Possiable reason

When I add a space in the front of the `line 2` however, the remaining text
doesn't play its role, such as the tags.

I notice that at line 2, there are double quotes within the double quotes.
Maybe that is syntax error. I try to remove the double quotes, thus
generting the text as

{% highlight ruby %}

    ---
    layout: post
    title: "Bootstrap: Page build failed from github server" # no quotes within quotes
    description: ""
    categories: tech
    tags: [Bootstrap]
    ---
{% endhighlight %}

It works either. Maybe that is the real solution.
