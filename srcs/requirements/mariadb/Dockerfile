FROM alpine:3.14.6

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		mariadb \
		mariadb-common \
		mariadb-client

COPY /tools/docker-entrypoint.sh /

# ENTRYPOINT [ "/bin/sh", "/docker-entrypoint.sh" ]

# CMD ["mysqld"]
