FROM debian:buster

COPY /Dockerfile /

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -yq update \
&& apt-get -yq install nginx \
&& apt-get clean -y 
