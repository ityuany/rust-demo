#!/usr/bin/env -S just --justfile

# Set shell configurations
set windows-shell := ["powershell"]
set shell := ["bash", "-cu"]

setup:
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
    cargo binstall taplo-cli watchexec-cli@2.2.1 -y
    @echo '✅ Setup complete!'

ready:
  just fmt    
  # just lint 
  @echo '✅ All passed!'

fmt:
    cargo fmt --all -- --emit=files
    taplo fmt **/*.toml
    @echo '✅ Format complete!'

lint: 
    cargo clippy --workspace --all-targets -- --deny warnings
    @echo '✅ Lint complete!'

watch:
    echo "Running the project..."
    # cargo watch -x build
    watchexec -r -e rs cargo build