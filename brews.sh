brew install git
brew install gh
brew install vim
brew install neovim
brew install tmux
brew install nodebrew
brew install deno
brew install sheldon
brew install ghq
brew install peco
brew install rustup-init

# 最新バージョン以外の取得を可能にする
brew tap homebrew/cask-versions

# プラグイン周りの依存解消
brew install pyenv
brew install rbenv ruby-build
brew install php

# bat: fzf.vim のプレビューに syntax highlight をつける
# ripgrep: (rg) 高速なgrep検索
brew install fzf
brew install bat
brew install ripgrep

# tmux でヤンクとクリップボードを繋げる
brew install reattach-to-user-namespace

# コードの行数カウント
brew install cloc

# プロセスを階層構造で出力
brew install pstree

# 現在エラー出る。brew install --build-from-source mono しろと言われるがひとまず入れずに様子見
# brew install mono

# dart は tap でのみ
brew tap dart-lang/dart
brew install dart

# vim-prettier
brew install prettier

# NeoVim の builtin lsp で not found になるから。(別になくてもlspインストールできるし使えるけど一応)
brew install wget

# brew cu
brew tap buo/cask-upgrade

# font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-cica
brew install --cask font-hackgen-nerd

# latex
brew install texlive
brew install texlab
brew install --cask skim

# other casks
brew install --cask alfred
brew install --cask android-studio
brew install --cask blender
brew install --cask deepl
brew install --cask discord
brew install --cask docker
brew install --cask dotnet-sdk
brew install --cask figma
brew install --cask firefox
brew install --cask github
brew install --cask google-chrome
brew install --cask grammarly
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask microsoft-office
brew install --cask notion
brew install --cask numi
brew install --cask rider
brew install --cask slack
brew install --cask toggl-track
brew install --cask unity-hub
brew install --cask visual-studio
brew install --cask visual-studio-code
brew install --cask zoom
