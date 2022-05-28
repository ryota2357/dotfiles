# zsh補完を有効に
#autoload -Uz compinit && compinit

# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# コンプリータの設定
#  _complete: 通常補完
#  _approximate: 近似補完 (間違いを修正した補完)
#  _prefix: 単語途中の補完 (/dir1/dir3/ -> /dir1/dir2/dir3/ という感じで)
zstyle ':completion:*' completer _complete _approximate _prefix

# 補完方法毎にグループ化する
zstyle ':completion:*' format '%B%F{63}%d%f%b'
zstyle ':completion:*' group-name ''

# 補完侯補をメニューから選択する
#  select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2