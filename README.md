# dotfiles

パッケージマネージャ: [Nix](https://nixos.org/)

1. Xcode command line tools をインストール
2. [nix-installer](https://github.com/DeterminateSystems/nix-installer) で Nix をインストール
3. [Homebrew](https://brew.sh/) をインストール
4. このリポジトリを clone
5. clone したディレクトリ以下で `nix run` を実行

## ahk/

2024年夏のインターンで windows を使った時に作った設定。

## bin/

`$HOME/.local/bin` に配置する。(Home Manager によって配置される)

| コマンド名   | 説明                                                                |
| :----------- | :------------------------------------------------------------------ |
| termcolors   | ターミナル 256 color の表を生成する                                 |
| tmux-connect | tmux への既存セッションへの接続 or 新規セッションの立ち上げを簡単に |
| trash        | macOS の Finder を利用した「ゴミ箱への移動」を行う                  |

## config-files/

1ファイルな設定はディレクトリを区切らずここにまとめて置いてある。

Nix から利用する場合は、`_generated.nix` が置いてあるので、それを `import` すれば使える。
また、この `default.nix` は `config-files/_generate_nix` により自動生成されるので、ファイルの追加・名前の変更をした際に実行すること。

## nix/

`flake.nix` に関する設定はここに配置され、`flake.nix` でインポートされる。

Home Manager の利用に関しては、以下の通りである。

- GUI ではないパッケージについては、Home Manager を基本的に使用する。ただし、rust や lern のような公式が使い勝手の良いパッケージマネージャを提供している場合はそれらを使用する。
  - GUI パッケージは Homebrew を nix-darwin 経由で使用してインストールする。
- Home Manager が新たにファイル設定ファイルを生成することはせず、`home.files` や `xdg.configFile` を使用して、ファイルのリンクを貼るようにする。
  - これは、Nix が使えない環境であっても、シンボリックリンクを貼ることでそれぞれの環境が構築できるようにするため。なので、Nix に依存する設定 (ファイル) は Home Manager が生成しても良い。

## scripts/

何かの setup 手順をまとめた sh ファイルを置いたり、適当なスクリプトを雑に置いておくところ。

## shell/

デフォルトのシェルは zsh、インタラクティブシェルとしてのみ fish を使用。

zsh、fish ともにプラグインマネージャは使用していない。

## tmux/

プラグインマネージャ: [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)

各種プラグインのインストールは `prefix` + <kbd>I</kbd> で行える。

## vim/

- Neovim (vim/init.lua)
- Vim (vim/vimrc)
- ideavim (vim/ideavimrc)

プラグインマネージャ: Neovim は [dein.vim](https://github.com/Shougo/dein.vim)、 Vim は [vim-jetpack](https://github.com/tani/vim-jetpack)

Neovim をメインエディタとして使用。
Vim は git や man など、軽量なテキスト編集用で、vimrc 一枚で持ち運べるようにしてる。
