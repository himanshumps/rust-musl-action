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

COPY couchbase.repo /etc/yum.repos.d/couchbase.repo

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum-config-manager --enable \* > /dev/null && \ 
    yum -y install rust cargo rustup openssl clang-devel libcouchbase3 libcouchbase-dev libcouchbase3-tools libcouchbase-dbg libcouchbase3-libev libcouchbase3-libevent libev-dev libevent-dev && \
    yum clean all -y

ENV BUILD_DIR=/build \
    OUTPUT_DIR=/output \
    RUST_BACKTRACE=1 \
    PREFIX=/toolchain

RUN mkdir -p $BUILD_DIR \
    && mkdir -p $OUTPUT_DIR \
    && mkdir -p $PREFIX

WORKDIR $PREFIX

WORKDIR $BUILD_DIR
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile default --default-toolchain stable
ENV PATH=$PATH:$HOME/.cargo/bin \
    RUSTUP_HOME=$HOME/.rust \
    CARGO_HOME=$HOME/.cargo
RUN rustup self update && rustup update
RUN rustup target add $BUILD_TARGET
RUN rustup component add clippy-preview
RUN rustup component add rustfmt-preview
RUN cargo install cargo-release


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
