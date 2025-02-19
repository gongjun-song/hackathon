FROM ubuntu:20.04

ARG http_proxy='http://proxy-dmz.intel.com:912'
ARG https_proxy='http://proxy-dmz.intel.com:912'
ARG no_proxy="intel.com,*.intel.com"
ENV DEBIAN_FRONTEND=noninteractive

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get install -y \
    build-essential \
    linux-headers-generic \
    git \
    vim \
    autoconf \
    automake \
    libtool \
    pkg-config \
    scdoc \
    libzstd-dev \
    liblzma-dev \
    zlib1g-dev \
    libssl-dev \
    gtk-doc-tools \
    libglib2.0-dev \
    && rm -rf /var/lib/apt/lists/*

COPY kmod /usr/src/kmod
WORKDIR /usr/src/kmod

RUN ./autogen.sh xg
RUN ./configure CFLAGS='-g -O2' \
    LDFLAGS='-ldl' --prefix=/usr \
    --sysconfdir=/etc --libdir=/usr/lib \
    --enable-debug --enable-gtk-doc \
    --with-zstd --with-xz --with-zlib \
    --with-openssl
RUN make && make install

CMD ["/bin/bash"]
