# Rocket Blog

An example blog built with Rocket.  It uses htmx and handlebar templates.

## Running

To run the blog, you need to have a recent version of Rust installed.  Then, run:

```bash
$ cargo run
```

## Multiplatform Docker Image

```
docker buildx create --use --name multiplatform
docker buildx build --platform linux/amd64,linux/arm64,linux/riscv64 --push -t drujensen/rocket-blog:latest .
```

