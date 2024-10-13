## EXPORT
export WINEARCH="win32"
export PAGER='less'
export HISTCONTROL=ignoreboth:erasedups
export EDITOR='vim'
export VISUAL='vim'
export DWM=~/.dwm
export DOOMGITCONFIG="$HOME/.gitconfig"

# Add TeX Live to the PATH, MANPATH, INFOPATH
export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

if [ -f /usr/share/z/z.sh ]; then
    .  /usr/share/z/z.sh
fi

if [ -d "$HOME/.config/emacs/bin" ] ;
then PATH="$HOME/.config/emacs/bin:$PATH"
fi
if [ -d "$HOME/.emacs.d/bin" ] ;
then PATH="$HOME/.emacs.d/bin:$PATH"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jc/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jc/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/jc/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jc/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/jc/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/jc/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

#################################
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export ELECTRON_MIRROR="https://cdn.npm.taobao.org/dist/electron/"
export NVM_DIR="$HOME/.nvm"
export PATH=$JAVA_HOME/bin:$PATH

# 插件配置
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="可用别名: "
export PRINT_ALIAS_IGNORE_REDEFINED_COMMANDS=true
export PRINT_ALIAS_IGNORE_ALIASES=(ls ll rm la vim vi ra =)
export NVM_AUTO_USE=true

## 对历史文件的配置（参考oh-my-zsh）
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## 对历史文件的配置
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# 显示隐藏文件
setopt globdots
