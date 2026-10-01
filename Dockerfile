FROM alpine:3.24

RUN apk add --no-cache jq

COPY assets/ /opt/resource/
RUN chmod +x /opt/resource/*
USER guest
