FROM rust:1.79-bullseye AS builder

RUN cargo install rqbit


FROM debian:bullseye-slim

COPY --from=builder /usr/local/cargo/bin/rqbit /usr/local/bin/rqbit

CMD ["/usr/local/bin/rqbit", "--http-api-listen-addr", "0.0.0.0:3030", "server", "start", "/data"]
