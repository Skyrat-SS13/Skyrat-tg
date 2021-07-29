#!/bin/bash

# Download Rust
curl https://sh.rustup.rs -sSfo rustup-init.sh
chmod +x rustup-init.sh
./rustup-init.sh -y

# Clone Custom TG RustG
git clone https://github.com/tgstation/rust-g.git
cd rust-g

# Setup RustG options
source $HOME/.cargo/env
rustup target add i686-unknown-linux-gnu

# Setup DPKG i386
dpkg --add-architecture i386
apt update
apt install -y zlib1g-dev:i386 libssl-dev:i386 pkg-config:i386

# Compile
export PKG_CONFIG_ALLOW_CROSS=1
export PATH="$HOME/.cargo/bin:$PATH"
cargo build --release --all-features --target i686-unknown-linux-gnu

# Copy compiled target to base
cp ./target/i686-unknown-linux-gnu/release/librust_g.so ./../librust_g.so

