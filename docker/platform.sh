#!/bin/bash

# Used in Docker build to set platform dependent variables

case $TARGETARCH in
  "amd64")
    echo "x86_64-unknown-linux-gnu" > /.platform
    echo "gcc-x86-64-linux-gnu" > /.compiler
    echo "x86_64-linux-gnu-gcc" > /.linker
    ;;
  "arm64")
    echo "aarch64-unknown-linux-gnu" > /.platform
    echo "gcc-aarch64-linux-gnu" > /.compiler
    echo "aarch64-linux-gnu-gcc" > /.linker
    ;;
  "riscv64")
    echo "riscv64gc-unknown-linux-gnu" > /.platform
    echo "gcc-riscv64-linux-gnu" > /.compiler
    echo "riscv64-linux-gnu-gcc" > /.linker
    ;;
esac
