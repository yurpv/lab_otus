FROM alpine:latest
MAINTAINER yurpv
RUN apk add --update --no-cache nginx \
&& adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G www-data -g www-data www-data \
&& addgroup -g 101 -S www-data \
&& mkdir -p /var/www/html \
&& mkdir -p /run/nginx \
&& chown -R www-data:www-data /var/lib/nginx \
&& chown -R www-data:www-data /var/www/html \ 

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
