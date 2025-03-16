FROM nginx:stable-perl

COPY ./localTesting/nginx.conf /etc/nginx/nginx.conf
COPY ./build/web /usr/share/nginx/html