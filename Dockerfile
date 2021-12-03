FROM --platform=linux/arm64 ubuntu:18.04

# RPC JSON
EXPOSE 8899/tcp
# RPC pubsub
EXPOSE 8900/tcp
# entrypoint
EXPOSE 8001/tcp
# (future) bank service
EXPOSE 8901/tcp
# bank service
EXPOSE 8902/tcp
# faucet
EXPOSE 9900/tcp
# tvu
EXPOSE 8000/udp
# gossip
EXPOSE 8001/udp
# tvu_forwards
EXPOSE 8002/udp
# tpu
EXPOSE 8003/udp
# tpu_forwards
EXPOSE 8004/udp
# retransmit
EXPOSE 8005/udp
# repair
EXPOSE 8006/udp
# serve_repair
EXPOSE 8007/udp
# broadcast
EXPOSE 8008/udp

RUN apt update
RUN apt-get install -y bzip2 \
    libssl-dev libudev-dev clang \
    vim wget curl gcc pkg-config
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y


ENV VERSION=1.8.3
RUN wget -O "/opt/solana-${VERSION}.tar.gz" "https://github.com/solana-labs/solana/archive/refs/tags/v${VERSION}.tar.gz"
RUN . ~/.cargo/env && echo $PATH
ENV PATH=~/.cargo/bin:$PATH
RUN cd /opt; tar -xvf "solana-${VERSION}.tar.gz"
RUN cd "/opt/solana-${VERSION}"; ./scripts/cargo-install-all.sh .
ENV PATH="/opt/solana-${VERSION}/bin:$PATH"
CMD ["/bin/bash"]
