FROM arm32v6/alpine:latest
COPY qemu-arm-static /usr/bin

RUN \
  mkdir /build && \
  wget https://github.com/szpajder/RTLSDR-Airband/archive/v3.0.1.tar.gz -O - \
    | tar -xzC /build && \
  apk add \
    --no-cache \
    g++ \
    lame-dev \
    libshout-dev \
    make \
    libconfig-dev \
    raspberrypi-dev \
    raspberrypi-libs && \
  apk add \
    --no-cache \
    --repository 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    librtlsdr-dev && \
  cd /build/RTLSDR-Airband-3.0.1 && \
  make PLATFORM=rpiv2 && \
  make install && \
  apk del \
    --no-cache \
    --rdepends \
    g++ \
    make && \
  rm -rf /build && \
  rm /usr/bin/qemu-arm-static

ENV LD_LIBRARY_PATH /opt/vc/lib
CMD ["/usr/local/bin/rtl_airband", "-Fec", "/rtl_airband.conf"]
