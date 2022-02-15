## Builder image
FROM alpine:edge as buildimage

# Build dependencies
ENV TZ="Australia/Melbourne"
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add build-base tzdata cmake samurai curl-dev rhash-dev jsoncpp-dev \
    tinyxml2-dev boost-dev zlib-dev htmlcxx-dev@testing wget curl jq tar gzip

# Compilation
WORKDIR /build
RUN wget $(curl -s "https://api.github.com/repos/sude-/lgogdownloader/releases/latest" | jq -r '.assets[].browser_download_url') -O /tmp/archive.tar.gz
RUN cd /build
RUN tar zxf /tmp/archive.tar.gz && \
  rm -f /tmp/archive.tar.gz && \
  cd $(ls) && ls -l && \
  cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -GNinja && \
  ninja -Cbuild install

## Runtime Image
FROM alpine:edge
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk --no-cache add ca-certificates && \
  apk --no-cache add curl rhash jsoncpp tinyxml2 zlib htmlcxx@testing boost

COPY --from=buildimage /usr/bin/lgogdownloader /usr/bin/lgogdownloader
COPY ./entrypoint.sh /opt/entrypoint.sh
WORKDIR /data
CMD ["lgogdownloader"]
ENTRYPOINT ["/opt/entrypoint.sh"]
