FROM alpine:3.14.6

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl 

COPY /conf /etc/nginx
COPY /tools/entrypoint.sh /

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;"]