# dotfiles

パッケージ管理: [Nix](https://nixos.org/)

1. Xcode Command Line Tools をインストール
2. [nix-installer](https://github.com/DeterminateSystems/nix-installer) を使って Nix をインストール
3. [Homebrew](https://brew.sh/) をインストール
4. このリポジトリをクローン
5. クローンしたディレクトリで `nix run` を実行

---

## bin/

`$HOME/.local/bin` に配置されるスクリプト (Home Manager によって配置される)。

| コマンド名     | 説明                                                                     |
| :------------- | :----------------------------------------------------------------------- |
| `termcolors`   | ターミナルの 256 色カラーコード表を生成する。                            |
| `tmux-connect` | 既存の tmux セッションへの接続や、新規セッションの立ち上げを簡単に行う。 |
| `trash`        | macOS の Finder と同様の「ゴミ箱への移動」機能を提供する。               |


## config-files/

単一ファイルで完結する設定をまとめている。

Nixから利用する場合、`_generated.nix` を `import` することで各設定ファイルへのパスを取得できる。
この `_generated.nix` は `config-files/_generate_nix` スクリプトによって自動生成されるため、ファイルを追加・変更した際はスクリプトを再実行すること。

## keymap/

キーマッピング設定をまとめている。

`kaymap/ahk` は 2024 年夏のインターンシップで Windows を使用した際に作成した AutoHotkey の設定。

## nix/

`flake.nix` で使用する設定を管理している。

Home Managerの利用方針:

- CLIツール: 使い勝手の良い公式のパッケージマネージャ (例: `rustup`, `elan`) が提供されている場合を除き、Home Manager で管理する。
- GUIアプリ: `nix-darwin` 経由で Homebrew を使い、インストールする。
- 設定ファイル: Home Manager による設定ファイル生成は行わず、`home.files` や `xdg.configFile` を通してシンボリックリンクを貼ることを原則とする。
  - 例外: Nixに依存する設定ファイルは、Home Manager が生成しても構わない。
  - 理由: この方針により、Nix が利用できない環境でも `symlink.sh` を使って環境を再現できるようになる。

## scripts/

セットアップ手順や、その他のユーティリティスクリプトを配置している。

| ファイル名      | 説明                                                                                  |
| :-------------- | :------------------------------------------------------------------------------------ |
| `gpg-setup.sh`  | GPG の設定、特に `pinentry-mac` の使用を強制する。                                    |
| `lean-setup.sh` | Lean (`elan`) のセットアップを行う。                                                  |
| `rust-setup.sh` | Rust (`rustup`) のセットアップと、開発でよく使う Cargo パッケージをインストールする。 |
| `symlink.sh`    | Nix 環境外で、dotfiles へのシンボリックリンクをホームディレクトリに作成する。         |

## shell/

デフォルトシェルは **zsh**、インタラクティブシェルとして **fish** を使用している。
どちらもプラグインマネージャは使用していない。

## tmux/

プラグインマネージャ: [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)

プラグインのインストールは `prefix` + <kbd>I</kbd> で行える。

## vim/

- Neovim: `vim/init.lua`
- Vim: `vim/vimrc`
- IdeaVim: `vim/ideavimrc`

プラグインマネージャ:

- Neovim: [dein.vim](https://github.com/Shougo/dein.vim)
- Vim: [vim-jetpack](https://github.com/tani/vim-jetpack)

メインエディタとしてNeovimを使用している。
Vim は、`git` のコミットメッセージ編集や `man` の閲覧など、軽量なテキスト編集用途に特化させており、`vimrc` 単体で動作するように設定している。
