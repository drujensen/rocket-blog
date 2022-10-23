FROM --platform=$BUILDPLATFORM rust:1.61.0 as builder
WORKDIR /app
ADD . /app
RUN cargo clean
RUN cargo build --release
 
FROM --platform=$TARGETPLATFORM ubuntu:22.10
WORKDIR /app
RUN mkdir /app/static
RUN mkdir /app/static/styles
RUN mkdir /app/static/scripts
RUN mkdir /app/static/images
RUN mkdir /app/templates
COPY --from=builder /app/target/release/rocket-blog /app
COPY --from=builder /app/static/styles/* /app/static/styles/
COPY --from=builder /app/static/scripts/* /app/static/scripts/
COPY --from=builder /app/static/images/* /app/static/images/
COPY --from=builder /app/templates/* /app/templates/
CMD ["/app/rocket-blog"]
