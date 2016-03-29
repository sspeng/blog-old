Deploy
===
A `Dockerfile` is included in this directory as a supplement to deploy this
static website. To create a docker image from the `Dockerfile`, run

``` bash
  docker build -t jekyll-3.0
```

Then you can use the scripts to deploy the website

``` bash
  ./deploy.sh
```
