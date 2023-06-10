# zsh補完を有効に
# autoload -Uz compinit && compinit

# オプション補完で解説部分を表示
zstyle ':completion:*' verbose yes

# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# コンプリータ(補完方法)の設定
# 指定した順に実行する
## _approximate: 近似補完 (間違いを修正した補完)
## _complete: 通常補完
## _correct: ミススペルを訂正した上で補完を行う
## _expand: グロブや変数の展開を行う。もともとあった展開と比べて、細かい制御が可能
## _history: 履歴から補完を行う。_history_complete_wordから使われる
## _ignored: 補完候補にださないと指定したものも補完候補とする
## _match: *などのグロブによってコマンドを補完できる
## _oldlist: 前回の補完結果を再利用
## _prefix: 単語途中の補完 (/dir1/dir3/ -> /dir1/dir2/dir3/ という感じで)
zstyle ':completion:*' completer _complete _approximate _prefix

# 補完方法毎にグループ化する
zstyle ':completion:*' format '%B%F{63}%d%f%b'
zstyle ':completion:*' group-name ''

# 補完侯補をメニューから選択する
#  select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

# https://github.com/yutkat/dotfiles/blob/0ab867368d1bc0828c22ba44a612a8ecb5ad6f03/.config/zsh/rc/completion.zsh#L62-L64
# make にて補完されるものを英数字のみで構成されるターゲットのみにする(?)
#  ↑ 補完されるものが PHONY なものだけになるようにしてるっぽい
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make::' tag-order targets:
zstyle ':completion:*:*:*make:*:targets' command awk \''/^[a-zA-Z0-9][^\/\t=]+:/ {print $1}'\' \$file
