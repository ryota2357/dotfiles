# rustc とか cargo とか、入れる
rustup-init

# cargo add で cargo.toml にパッケージ追加できるように
cargo install cargo-edit

# rustfmt フォーマッタ
rustup component add rustfmt

# cargo clippy で rustコードの静的解析
rustup component add clippy

# LSP関連、なんか入れなくてもnvim-lspでは問題ないけど一応
rustup component add rls rust-src rust-analysis

# macwordコマンド: https://github.com/high-moctane/mocword
cargo install mocword
