# rustc とか cargo とか、入れる
rustup-init

# パス通す
. "$HOME/.cargo/env"

# https://rust-lang.github.io/rustup/concepts/components.html
# rustc         — The Rust compiler and Rustdoc.
# cargo         — Cargo is a package manager and build tool.
# rustfmt       — Rustfmt is a tool for automatically formatting code.
# rust-std      — This is the Rust standard library. There is a separate rust-std component for each target that rustc supports, such as rust-std-x86_64-pc-windows-msvc. See the Cross-compilation chapter for more detail.
# rust-docs     — This is a local copy of the Rust documentation. Use the rustup doc command to open the documentation in a web browser. Run rustup doc --help for more options.
# rust-analyzer — rust-analyzer is a language server that provides support for editors and IDEs.
# clippy        — Clippy is a lint tool that provides extra checks for common mistakes and stylistic choices.
# rust-src      — This is a local copy of the source code of the Rust standard library. This can be used by some tools, such as RLS, to provide auto-completion for functions within the standard library; Miri which is a Rust interpreter; and Cargo's experimental build-std feature, which allows you to rebuild the standard library locally.
# rust-analysis — Metadata about the standard library, used by tools like RLS.
rustup component add \
    rustc cargo rustfmt rust-std rust-docs rust-analyzer clippy rust-src rust-analysis

# cargo add で cargo.toml にパッケージ追加できるように
cargo install cargo-edit

# macwordコマンド: https://github.com/high-moctane/mocword
cargo install mocword

# mdbookコマンド
cargo install mdbook

# cargo expand でマクロを展開
cargo install cargo-expand

# cargo install したのをアプデする ($ cargo install-update --all)
cargo install cargo-update

# カバレッジ計測ツール ($ cargo llvm-cov)
cargo install cargo-llvm-cov
rustup component add llvm-tools-preview
