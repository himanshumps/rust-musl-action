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
RUN yum -y install gcc
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile default --default-toolchain stable

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
