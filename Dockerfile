FROM registry.access.redhat.com/ubi7/ubi:latest
LABEL name="rust-musl-builder"
LABEL version="1.0.0"
LABEL repository="https://github.com/himanshumps/rust-musl-action"
LABEL homepage="https://github.com/himanshumps/rust-musl-action"
LABEL maintainer="Himanshu Gupta"

LABEL com.github.actions.name="Rust MUSL Builder"
LABEL com.github.actions.description="Provides a Rust MUSL environment"
LABEL com.github.actions.icon="settings"
LABEL com.github.actions.color="orange"

ENV PATH=$PATH:$HOME/.cargo/bin \
    RUSTUP_HOME=$HOME/.rustup \
    CARGO_HOME=$HOME/.cargo

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile default --default-toolchain stable

COPY couchbase.repo /etc/yum.repos.d/couchbase.repo

RUN yum -y install install -y \
    https://repo.ius.io/ius-release-el7.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum-config-manager --enable \* > /dev/null && \ 
    curl -O https://packages.couchbase.com/clients/c/libcouchbase-3.1.1_centos7_x86_64.tar && \
    tar xf libcouchbase-3.1.1_centos7_x86_64.tar && \
    cd libcouchbase-3.1.1_centos7_x86_64 && \
    yum install -y libcouchbase*.rpm && \
    cd .. && \
    yum -y install  libev-dev libev-devel libevent-dev libevent-devel wget && \
    wget -q https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3-Linux-x86_64.sh && \
    chmod 777 cmake-3.19.3-Linux-x86_64.sh && \
    /bin/sh ./cmake-3.19.3-Linux-x86_64.sh --skip-licence --prefix=/usr/local --exclude-subdir && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum-config-manager --enable \* > /dev/null && \ 
    yum -y install git-all perl-core pkg-config cmake make g++ make gcc gcc-c++ openssl openssl-devel clang-devel  && \
    yum clean all -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
