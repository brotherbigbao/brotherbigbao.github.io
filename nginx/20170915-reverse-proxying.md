# Nginx reverse proxying
> 转自: 《Mastering NGINX》Second Edition

Introducing reverse proxying
NGINX can serve as a reverse proxy by terminating requests from clients and
opening new ones to its upstream servers. On the way, the request can be split
up according to its URI, client parameters, or some other logic, in order to best
respond to the request from the client. Any part of the request's original URL
can be transformed on its way through the reverse proxy.

The most important directive when proxying to an upstream server is the
**proxy_pass** directive. This directive takes one parameter—the URLto which
the request should be transferred. Using **proxy_pass** with a URI part will
replace the **request_uri** variable with this part. For example, **/uri** in the
following example will be transformed to **/newuri** when the request is passed
on to the upstream:

```
location /uri {
    proxy_pass http://localhost:8080/newuri;
}
```

There are two exceptions to this rule, however. First, if the location is defined
with a regular expression, no transformation of the URI occurs. In this
example, the URI, **/local**, will be passed directly to the upstream, and not be
transformed to **/foreign** as intended:

```
location ~ ^/local {
    proxy_pass http://localhost:8080/foreign;
}
```

The second exception is that if within the location a rewrite rule changes the
URI, and then NGINX uses this URI to process the request, no transformation
occurs. In this example, the URI passed to the upstream will be **/index.php?
page=<match>**, with **<match>** being whatever was captured in the
parentheses, and not **/index**, as indicated by the URI part of the **proxy_pass**
directive:

```
location / {
    rewrite /(.*)$ /index.php?page=$1 break;
    proxy_pass http://localhost:8080/index;
}
```

The **break** flag to the **rewrite** directive is used here to immediately stop all
processing of **rewrite** module directives.
In both of these cases, the URI part of the **proxy_pass** directive is not
relevant, so the configuration would be complete without it:

```
location ~ ^/local {
    proxy_pass http://localhost:8080;
}
location / {
    rewrite /(.*)$ /index.php?page=$1 break;
    proxy_pass http://localhost:8080;
}
```

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)