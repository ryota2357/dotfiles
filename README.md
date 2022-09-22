# dotfiles

[Homebrew](https://brew.sh/index_ja)

## tmux

プラグインマネージャに [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) を使用。  
TPM は現在(2022/9/22) `git clone` でしか入れられないっぽい(?)ので [README.md](https://github.com/tmux-plugins/tpm/blob/master/README.md) を確認してインストールすること。

各種プラグインのインストールは `prefix` + <kbd>I</kbd> で行える。

## vim

- Neovim (init.lua)
- ideavim (vimrc)

プラグインマネージャに[dein.vim](https://github.com/Shougo/dein.vim)を使用。  
手動でインストールしなくても自動的にインストールされる。

### checkhealth

書いた https://ryota2357.com/blog/2022/nvim-checkhealth-path/

## vscode

昔に作った設定を保存したほうがよさそうな物だけ突っ込んだ。  
いちから設定する必要がある。

## zsh

プラグインマネージャに [sheldon](https://github.com/rossmacarthur/sheldon) を使用。  
Homebrew でインストールしてる。setup は sheldon の　README。

プラグインのアップデートは

```sh
sheldon lock --update
```
