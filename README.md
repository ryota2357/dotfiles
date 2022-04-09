# dotfiles

[Homebrew](https://brew.sh/index_ja)

|  type  |   arm64   | x86_64 |
| :----: | :-------: | :----: |
|  tmux  |    ok     |   ー   |
|  vim   | nvim のみ |   ー   |
| vscode |  未設定   |   ー   |
|  zsh   |    ok     |   ー   |

## tmux

プラグインマネージャに [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) を使用。  
TPM は現在(2022/4/9) `git clone` でしか入れられないっぽい(?)ので [README.md](https://github.com/tmux-plugins/tpm/blob/master/README.md) を確認してインストールすること。

各種プラグインのインストールは `prefix` + <kbd>I</kbd> で行える。

## vim

NeoVim のみ対応してない。  
なので `~/.vimrc` にシンボリックリンクを作ってはいけない。エラーがたくさん出る。

プラグインマネージャに[dein.vim](https://github.com/Shougo/dein.vim)を使用  
手動でインストールしなくても自動的にインストールされると思う。

### checkhealth

NeoVim の `:checkhealth` 対応方法

#### python

`pyenv` がすでに Homebrew で入ってると思う。  
その後の手順は pyenv の[README.md の Installation](https://github.com/pyenv/pyenv/blob/master/README.md#installation)を参考に進める。  
zsh にパスを通す、init の実行はすでに zshrc, zprofile 記述済みであるかもだけど、確認する

続いて python をインストールする

```sh
# install できるバージョンの確認
pyenv install --list

# install
pyenv install 3.*.*

# global にする
pyenv global 3.*.*
```

ここで NeoVim で `:checkhealth` を実行して指示に従い NeoVim プラグインを入れる。

```sh
# ヘルプを見ろと言われて、見に行くと
# 多分こんな感じのコマンドを実行しろと言われる
python3 -m pip install --user --upgrade pynvim
```

#### ruby

`rbenv` がすでに Homebrew で入ってると思う。  
その後の手順は rbenv の[README.md の Installation](https://github.com/rbenv/rbenv/blob/master/README.md#installation)を参考に進める。  
init の実行はすでに zshrc に記述済みであるかもだけど、確認する。

続いて ruby をインストールする。

```sh
# install できるバージョンの確認
rbenv install --list

# install
rbenv install 3.*.*

# global にする
pyenv global 3.*.*
```

ここで NeoVim で `:checkhealth` を実行して指示に従い NeoVim プラグインを入れる。

```sh
# 多分こんな感じのコマンドを実行しろと言われる
gem install neovim
```

## vscode

昔に作った設定を保存したほうがよさそうな物だけ突っ込んだ。  
いちから設定する必要がある。

## zsh

プラグインマネージャに [zplug](https://github.com/zplug/zplug) を使用  
Homebrew でインストールしてる。
