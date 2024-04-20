# dotfiles

[Homebrew](https://brew.sh/index_ja)

## tmux

プラグインマネージャに [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) を使用。  
TPM は現在(2022/9/22) `git clone` でしか入れられないっぽい(?)ので [README.md](https://github.com/tmux-plugins/tpm/blob/master/README.md) を確認してインストールすること。

各種プラグインのインストールは `prefix` + <kbd>I</kbd> で行える。

## vim

- Neovim (vim/init.lua)
- Vim (vim/vimrc)
- ideavim (vim/ideavimrc)

プラグインマネージャは Neovim には[dein.vim](https://github.com/Shougo/dein.vim), Vim には [vim-jetpack](https://github.com/tani/vim-jetpack)を使用。  
手動でインストールしなくても自動的にインストールされる。

Neovim がメインエディタ。Vim は vimrc 一枚で持ち運べるようにしてる。

### checkhealth

書いた https://ryota2357.com/blog/2022/nvim-checkhealth-path/

## zsh

プラグインマネージャに [sheldon](https://github.com/rossmacarthur/sheldon) を使用。  
Homebrew でインストールしてる。setup は sheldon の README。

プラグインのアップデートは

```sh
sheldon lock --update
```
