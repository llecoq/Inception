FROM alpine:3.15.4

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl 

COPY /conf /etc/nginx
COPY /tools/entrypoint.sh /

ENTRYPOINT [ "sh", "/entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;"]