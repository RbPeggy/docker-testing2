# docker header
FROM gliderlabs/alpine:edge
MAINTAINER Rosemarie Peggy <r0s3b3rn@gmail.com>

# setting timezone
ENV TZ=America/Edmonton
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# package update
RUN apk update

# package install
RUN apk add --update tzdata bash supervisor nginx

#Copy the basic file in place (it is empty right now)
COPY supervisord.conf /etc/supervisord.conf

# create run directory
RUN mkdir -p /run/nginx
COPY default.conf  /etc/nginx/conf.d/default.conf
COPY website/* /var/www/localhost/htdocs/

# exposing port 80
EXPOSE 80

#Starting point of container
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
