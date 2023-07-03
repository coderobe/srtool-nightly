FROM docker.io/paritytech/srtool:1.70.0

LABEL maintainer "coderobe"
LABEL description="inadvisable, not prod"

ENV DOCKER_IMAGE="coderobe/srtool-nightly"
ENV PROFILE=release
ENV PACKAGE=polkadot-runtime
ENV BUILDER=builder
ARG UID=1001
ARG GID=1001

ENV SRTOOL_TEMPLATES=/srtool/templates

WORKDIR /tmp
ENV DEBIAN_FRONTEND=noninteractive

# Tooling
ARG SUBWASM_VERSION=0.20.0
ARG TERA_CLI_VERSION=0.2.4
ARG TOML_CLI_VERSION=0.2.4

USER $BUILDER
ENV RUSTUP_HOME="/home/${BUILDER}/rustup"
ENV CARGO_HOME="/home/${BUILDER}/cargo"
ENV PATH="/srtool:$PATH"

RUN echo $SHELL && \
    . $CARGO_HOME/env && \
    rustup toolchain add nightly && \
    rustup target add wasm32-unknown-unknown && \
    rustup default nightly && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
    rustup show && rustc -V

VOLUME [ "/build", "$CARGO_HOME", "/out" ]
WORKDIR /srtool

CMD ["/srtool/build"]
