FROM ubuntu:focal
LABEL maintainer="christopher.shields143@gmail.com"
SHELL ["/bin/bash", "-c"]

# apparently there's a bug in ubuntu's official docker image?
# apt-get will use /linux/debian instead of /linux/ubuntu for packages
# (cf https://askubuntu.com/questions/1189679), so we need to change it
RUN sed -i 's|docker.com/linux/debian|docker.com/linux/ubuntu|g' /etc/apt/sources.list

# get all tools necessary for building python from source
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    build-essential \
    zlib1g-dev \
    libffi-dev \
    xz-utils

# get all tools necessary to USE python after building
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev

# build python 3.6
COPY Python-3.6.13.tar.xz /
RUN tar xfJ Python-3.6.13.tar.xz && \
    rm Python-3.6.13.tar.xz && \
    cd Python-3.6.13 && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf Python-3.6.13

# build python 3.7
COPY Python-3.7.10.tar.xz /
RUN tar xfJ Python-3.7.10.tar.xz && \
    rm Python-3.7.10.tar.xz && \
    cd Python-3.7.10 && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf Python-3.7.10

# build python 3.8
COPY Python-3.8.8.tar.xz /
RUN tar xfJ Python-3.8.8.tar.xz && \
    rm Python-3.8.8.tar.xz && \
    cd Python-3.8.8 && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf Python-3.8.8
