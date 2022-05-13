FROM alpine:3.14.6

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl

# lancer script pour parametrer ssl etc

COPY /conf /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
# CMD [ "sh" ]