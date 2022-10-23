FROM rust:1.61.0 as builder
WORKDIR /app
ADD Cargo.* /app
ADD Rocket.toml /app
Run cargo deps
ADD src /app/src
RUN cargo build --release
ADD static /app/static
ADD templates /app/templates
ADD config /app/config

FROM ubuntu:22.04
WORKDIR /app
RUN apt-get update && apt-get install -y wget curl git file
RUN mkdir /app/config
RUN mkdir /app/templates
RUN mkdir /app/static
RUN mkdir /app/static/styles
RUN mkdir /app/static/scripts
RUN mkdir /app/static/images
COPY --from=builder /app/target/release/rocket-blog /app
COPY --from=builder /app/config/* /app/config/
COPY --from=builder /app/templates/* /app/templates/
COPY --from=builder /app/static/styles/* /app/static/styles/
COPY --from=builder /app/static/scripts/* /app/static/scripts/
COPY --from=builder /app/static/images/* /app/static/images/
CMD ["/app/rocket-blog"]
