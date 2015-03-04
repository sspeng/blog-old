---
layout: post
title: "Check root previledge in bash script"
modified:
categories: tech
excerpt:
tags: []
image:
  feature:
---

UID is an important environment variable that can be used to check whether the
current script has been run as root user or regular user. For example:

{% highlight bash %}
if [ ${UID} -ne 0 ]; then
    echo "Not root user. Please run as root"
else
    echo "Root user"
fi
{% endhighlight %}

The UID for the root user is 0
