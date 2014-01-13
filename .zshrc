# キーバインドモード {
    # vim
    bindkey -v
    # emacs
    #bindkey -e
# }

# コマンド補完 {
    # 補完機能を有効にする
    autoload -U compinit; compinit
    # 補完候補を一覧で表示する(d)
    setopt auto_list
    # 補完キー連打で補完候補を順に表示する(d)
    setopt auto_menu
    # 補完候補をできるだけ詰めて表示する
    setopt list_packed
    # 補完候補にファイルの種類も表示する
    setopt list_types
    # グロブ機能を拡張する
    setopt extended_glob
    # ファイルグロブで大文字小文字を区別しない
    #unsetopt caseglob
    # 補完時に大文字小文字を区別しない
    #zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
    bindkey "^[[Z" reverse-menu-complete
# }

# コマンド履歴 {
    # ヒストリを保存するファイル
    HISTFILE=~/.zsh_history
    # メモリに保存されるヒストリの件数
    HISTSIZE=10000
    # 保存されるヒストリの件数
    SAVEHIST=1000000
    # !を使ったヒストリ展開を行う(d)
    setopt bang_hist
    # ヒストリに実行時間も保存する
    setopt extended_history
    # 直前と同じコマンドはヒストリに追加しない
    setopt hist_ignore_dups
    # 他のシェルのヒストリをリアルタイムで共有する
    setopt share_history
    # 余分なスペースを削除してヒストリに保存する
    setopt hist_reduce_blanks
# }

# コマンド検索 {
    autoload history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey "^P" history-beginning-search-backward-end
    bindkey "^N" history-beginning-search-forward-end
    bindkey "^R" history-incremental-pattern-search-backward
    bindkey "^S" history-incremental-pattern-search-forward
    stty stop undef # Ctrl+Sでの端末ストップを無効化（インクリメントサーチのため）
# }

# コマンド予測 {
  #autoload predict-on; predict-on
# }

# プロンプト設定 {
    autoload colors; colors
    local p_host="%F{blue}%B%n%b%f@%F{gray}%m%f"
    local p_mark="%(!,#,$)"
    local p_cdir="%F{green}%d%f"
    local p_date="%D %T"
    PROMPT="[$p_host]$p_mark "
    PROMPT2="> "
    RPROMPT="[$p_cdir] $p_date"
# }

# lsカラー設定 {
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    export ZLS_COLORS=$LS_COLORS
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
# }

# その他オプション {
    # ビープ音を鳴らさないようにする
    setopt no_beep
    # ディレクトリ名の入力のみで移動する
    setopt auto_cd
    # cd時にディレクトリスタックにpushdする
    setopt auto_pushd
    # コマンドのスペルを訂正する
    setopt correct
    # =以降も補完する(--prefix=/usrなど)
    setopt magic_equal_subst
    # プロンプト定義内で変数置換やコマンド置換を扱う
    setopt prompt_subst
    # バックグラウンドジョブの状態変化を即時報告する
    setopt notify
    # =commandを`which command`と同じ処理にする
    setopt equals
    # 日本語ファイル名を表示可能にする
    setopt print_eight_bit
# }

# Alias {
    # コマンド履歴全件表示
    alias ha="history -i 0"
    # 隠しファイルls
    alias la="ls -al"
    # tmux 256色
    alias t="tmux -2"
    # tmux アタッチ
    alias ta="t a"
    # php xdebug
    alias phpx="php-xdebug"
# }

# 外部アプリ用 {
    # tmux powerline 用 (https://github.com/erikw/tmux-powerline)
    PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
# }
