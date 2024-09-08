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
    # コマンドのスペルを訂正しない
    unsetopt correctall
    # kubectl
    [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
    # minikube
    [[ $commands[minikube] ]] && source <(minikube completion zsh)
    # yarn
    [[ -f ~/.zsh-yarn-completions/zsh-yarn-completions.plugin.zsh ]] &&\
      source ~/.zsh-yarn-completions/zsh-yarn-completions.plugin.zsh
# }

# コマンド履歴 {
    # ヒストリを保存するファイル
    HISTFILE=~/.zsh_history
    # メモリに保存されるヒストリの件数
    HISTSIZE=100000
    # 保存されるヒストリの件数
    SAVEHIST=10000000
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
    # ディレクトリ作成後、カレントディレクトリに
    function mkdircd() { mkdir -p "$@" && eval cd "\"\$$#\""; }
    # 色付きls
    case "${OSTYPE}" in
        darwin*) alias ls="ls -G" ;;
        linux*)  alias ls='ls --color' ;;
        *)       alias ls='ls' ;;
    esac
    # リストls
    alias ll="ls -l"
    # 隠しファイルリストls
    alias la="ls -al"
    # コマンド履歴全件表示
    alias ha="history -i 0"
    # tmux 256色
    alias t="tmux -2"
    # tmux アタッチ
    alias ta="t a"
    # vagrant rsync & vagrant ssh
    alias vssh="vagrant rsync-auto &> /dev/null & vagrant ssh && fg"
    # bundle exec (noglob)
    alias be="noglob bundle exec"
    # bundle exec spring (noglob)
    alias bes="noglob bundle exec spring"
    # brew
    alias brew-tree="brew list | xargs brew deps --tree"
    # npm
    alias npms="npm start"
    alias npme="npm run $1 --"
    alias npmt="npm run test:watch"
    # deno
    alias denot="deno task"
    # docker
    function docker_compose_clean() {
        docker rm -fv `docker-compose ps -q`
    }
    function docker_rm_all() {
        docker rm -fv `docker ps -aq`
    }
    function docker_rmi_none {
        docker rmi $(docker images -qf "dangling=true")
    }
    function docker_rm_build {
        docker rm `docker ps -a | grep '/bin/sh -c' | awk '{print $1}'`
    }
    function docker_machine_eval_env {
        eval $(docker-machine env ${1-default})
    }
    function docker_machine_eval_env_swarm {
        eval $(docker-machine env --swarm ${1-default})
    }
    alias fig="docker compose"
    alias fige="fig exec"
    alias figa="fige app"
    alias figr="docker-compose run --rm"
    alias figra="figr app"
    alias fig-clean="docker_compose_clean"
    alias docker-rmall="docker_rm_all"
    alias docker-rminone="docker_rmi_none"
    alias docker-rmbuild="docker_rm_build"
    alias dom="docker-machine"
    alias dome="docker_machine_eval_env"
    alias domes="docker_machine_eval_env_swarm"
    alias domfault="eval \$(dom env default)"
    # git
    function git-branch-delete-all {
      current_branch="$(git rev-parse --abbrev-ref HEAD)"
      default_branch="$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')"
      git checkout -q "$default_branch"
      git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do
        merge_base="$(git merge-base "$default_branch" "$branch")"
        [[ "$(git cherry "$default_branch" "$(git commit-tree "$(git rev-parse "$branch^{tree}")" -p "$merge_base" -m _)")" == "-"* ]] && \
          git branch -D "$branch"
      done
      git checkout "$current_branch"
    }
    # kubectl
    alias kube="kubectl"
    alias kubec="kubectl"
    alias kubea="kubectl apply -f"
    alias kubed="kubectl delete -f"
    alias kubeb="kubectl run busybox --image=busybox --image-pull-policy=IfNotPresent --restart=Never -it --rm"
    function kuben {
      if [ "${1:-undef}" = "undef" ]; then
        kubectl config get-contexts
      else
        kubectl config set-context $(kubectl config current-context) --namespace=$1
      fi
    }
    # Terraform
    alias ter="terraform"
    # Haskell
    alias rhs="runhaskell Setup.hs"
    # php xdebug
    alias phpx="env XDEBUG_CONFIG='idekey=xdebug' php"
    # zshrc再読み込み
    alias rc="source ~/.zshrc; echo '.zshrc reloaded'"
    alias rr="rc"
    # vim 新セッション作成
    alias vimnew="rm -rf .vimsessions; mkdir .vimsessions; vim +SaveSession"
    alias vimn="vimnew"
    # MacOSX用 tmux経由でアプリを起動すると色々うまくいかない問題の解決法
    # http://dev.jgs.me/2015/01/06/atom-LSOpenURLsWithRole-error.html
    # http://qiita.com/itkrt2y/items/dee87c406617d1bd45a6
    alias reattach="which reattach-to-user-namespace > /dev/null && reattach-to-user-namespace -l $SHELL || $SHELL"
    # JWT
    # Usage `pbpaste | jwtd`
    # Alt: alias jwtdecode='tr "." "\n" | tr -- "-_" "+/" | head -n 2 | base64 -D'
    function jwtd {
      jq -R 'gsub("-";"+") | gsub("_";"/") | split(".") | .[0,1] | @base64d | fromjson'
    }
    # export .env
    function dotenv {
      export $(cat "${1:-.env}" | grep -v '^#' | grep -v '^$' | xargs)
    }
    # fzf
    alias fzfm="fzf -e -i --reverse --no-sort --multi --select-1"
    # encrypted volume on icloud
    function encmount {
      printf '%s\0' "$(cat ~/Google\ Drive/マイドライブ/etc/encrypted.dmg)" | hdiutil attach ~/icloud/encrypted.dmg -stdinpass
    }
    alias encunmount="hdiutil detach /Volumes/encrypted"
    function encenv {
      args="$@"
      encmount 2> /dev/null || true
      if [ -e /Volumes/encrypted ]; then
        find /Volumes/encrypted/env -name '*.txt' | sort | fzfm --query "$args" | while read script; do
          # NOTE: `.` command is `source`
          . "$script"
        done
        encunmount 2> /dev/null
      fi
    }
    alias ee="encenv"
    # execute script on icloud
    function ish {
      args="$@"
      pushd ~/icloud/scripts > /dev/null
      find . -name '*.sh' | sort | fzfm --query "$args" --preview "bat --color=always --style numbers {}" | while read script; do
        cat "$script"
        echo
        source "$script"
      done
      popd > /dev/null
    }
    # bitwarden
    function bwexp {
      token="$(bw unlock --raw --session $(( 60 * 60 * 24 * 5 )))"
      zshlocal="${HOME}/.zshrc.local"
      sed -i '' '/^export BW_SESSION=/d' "$zshlocal"
      echo export BW_SESSION=\"$token\" >> "$zshlocal"
      source "$zshlocal"
    }
# }

# PATH環境変数設定 {
    # zshenvだと、優先度がデフォルトより低くなるため、こっちに移動
    PATH=$HOME/bin:$PATH
    PATH=$HOME/local/bin:$PATH
    PATH=./bin:$PATH
    PATH=./sbin:$PATH
    PATH=./node_modules/.bin:$PATH
    export PATH
# }

# 外部アプリ用 {
    # tmux powerline 用 (https://github.com/erikw/tmux-powerline)
    PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

    # https://www.rust-lang.org/tools/install
    if [ -s "$HOME/.cargo/env" ]; then
      source "$HOME/.cargo/env"
    fi

    # adsf
    if [ -s "$HOME/.asdf/asdf.sh" ]; then
      . $HOME/.asdf/asdf.sh
      # NOTE: asdf.sh だけだと VSCode と iTerm2 の PATH が変わる？
      export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"
    fi

    # aqua
    if [ -d "${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin" ]; then
      export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
    fi

    # Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
    export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
    if [ -d "$GHC_DOT_APP" ]; then
        export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
    fi
# }

# 外部ファイル読み込み {
    # ローカル用設定ファイル
    [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
# }

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/namikingsoft/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/namikingsoft/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/namikingsoft/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/namikingsoft/google-cloud-sdk/completion.zsh.inc'; fi

# Load keychain
ssh-add -K &> /dev/null
