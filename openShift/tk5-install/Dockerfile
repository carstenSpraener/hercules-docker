#
# Download TK5, unzip it and copy the files to /data
# /data must be mounted to the hercules pvc
#
FROM alpine:latest

WORKDIR /running

COPY tk5-install.sh .
RUN apk update && \
    apk add rsync wget zip

VOLUME /data

CMD ["/bin/sh", "-f", "/running/tk5-install.sh"]
