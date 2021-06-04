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
    
COPY couchbase.repo /etc/yum.repos.d/couchbase.repo

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum-config-manager --enable \* > /dev/null && \ 
    yum -y install cmake gcc openssl openssl-devel clang-devel libcouchbase3 libcouchbase-dev libcouchbase3-tools libcouchbase-dbg libcouchbase3-libev libcouchbase3-libevent libev-dev libevent-dev && \
    yum clean all -y

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile default --default-toolchain stable

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
