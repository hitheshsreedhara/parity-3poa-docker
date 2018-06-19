FROM ubuntu

WORKDIR /build

# install tools and dependencies
RUN apt-get -y update && \
        apt-get install -y --force-yes --no-install-recommends \
        curl git make g++ gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
        libc6-arm64-cross libc6-dev-arm64-cross wget file ca-certificates \
        binutils-aarch64-linux-gnu libssl1.0.0 \
        && \
    apt-get clean
    
# install rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# install parity from source binary
RUN wget https://d1h4xl4cr1h0mo.cloudfront.net/v1.10.6/x86_64-unknown-linux-gnu/parity_1.10.6_ubuntu_amd64.deb

RUN dpkg -i parity_1.10.6_ubuntu_amd64.deb

EXPOSE 8080 8545 8180
ENTRYPOINT ["parity"]
