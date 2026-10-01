FROM alpine:3.24

RUN apk add --no-cache jq

COPY assets/check /opt/resource/check
COPY assets/in /opt/resource/in
RUN chmod +x /opt/resource/check /opt/resource/in
USER guest
