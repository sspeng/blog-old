# This file is ONLY used for creating a docker image to host my personal
# blog. The gem packages and dependencies may not work for other jekyll blogs.
#
# If you want to create a jekyll image for your jekyll static website,
# you can customize this file as you want.
#
# Roadmap:
# 2015-03-29: upgrade jekyll to 3.0 and use rouge instead of pygments
#
FROM centos:7

MAINTAINER Conghui He <heconghui@gmail.com> version: 2.0

RUN yum update -y && yum clean all

RUN yum install -y epel-release

RUN yum install -y ruby \
                   ruby-devel \
                   nodejs

RUN yum install -y httpd
RUN yum install -y rubygems npm
RUN yum install -y make
RUN gem install jekyll -v 3.0
RUN gem install jekyll-sitemap
RUN gem install kramdown -v 1.10
RUN gem install rouge

EXPOSE 4000/tcp
