FROM rust:1.80-bookworm AS builder

RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y libssl-dev curl nodejs && \
    apt-get clean
RUN cargo install rqbit


FROM gcr.io/distroless/cc-debian12

COPY --from=builder /usr/local/cargo/bin/rqbit /usr/local/bin/rqbit

CMD ["/usr/local/bin/rqbit", "--http-api-listen-addr", "0.0.0.0:3030", "server", "start", "/data"]
