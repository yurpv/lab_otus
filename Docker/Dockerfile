FROM alpine:latest
MAINTAINER yurpv
RUN apk add --update --no-cache nginx \
&& adduser -D -g 'www' www \
&& mkdir /www/ \
&& mkdir /www/html \
&& mkdir -p /run/nginx 

ADD https://raw.githubusercontent.com/yurpv/lab_otus/main/Docker/nginx.conf /etc/nginx/
ADD https://raw.githubusercontent.com/yurpv/lab_otus/main/Docker/index.html /www/html/

RUN chown -R www:www /var/lib/nginx \
&& chown -R www:www /www/html 

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
