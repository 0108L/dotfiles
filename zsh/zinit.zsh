# https://github.com/zdharma-continuum/zinit
# https://www.cnblogs.com/hongdada/p/14048612.html
# https://asmcn.icopy.site/awesome/awesome-zsh-plugins/#tutorials
# https://github.com/Aloxaf/dotfiles/blob/master/zsh/.config/zsh/zshrc.zsh

# zsh-defer 一个延迟执行的zsh命令
#NOTE: eg: zsh-defer -c 'eval $(thefuck --alias)' 
zinit light-mode depth"1" for \
  romkatv/zsh-defer

# 加载 zsh 的补全
zinit wait lucid depth"1" atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions

# 加载 oh-my-zsh 的 lib 库
zinit light-mode for \
 OMZL::completion.zsh \
 OMZL::key-bindings.zsh

# 加载 oh-my-zsh 的插件
zinit wait"1" light-mode lucid for \
 OMZP::git \
 OMZP::sudo \
 OMZP::docker

# 加载 fzf 的补全
zinit ice lucid wait depth'1' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

##program
# https://github.com/rinx/dotfiles/blob/main/zshrc

# 应用程序 开始 -----------
# fzf 模糊搜索工具
# zinit ice wait lucid from"gh-r" as"program"
# zinit light junegunn/fzf

# fd 和 find 命令一样
# zinit ice lucid wait from"gh-r" \
#         as"program" \
#         mv"fd* -> fd" \
#         pick"fd/fd" \
#         nocompletions
# zinit light sharkdp/fd

# exa 和 ls 命令一样
# zinit ice wait lucid from"gh-r" as"program" pick"bin/exa"
# zinit light ogham/exa

# bat 和 cat 命令一样
# zinit ice lucid wait from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
# zinit light sharkdp/bat

# rg 和 grep 命令一样
# zinit ice lucid wait from"gh-r" \
#         as"program" \
#         mv"ripgrep* -> rg" \
#         pick"rg/rg" \
#         nocompletions
# zinit light BurntSushi/ripgrep

# ranger 是一个终端的文件管理器
# zinit ice depth'1' as'program' pick'ranger.py' atload'alias ranger=ranger.py'
# zinit light ranger/ranger

# FIXME: 按Q退出ranger时记住路径
# 用于兼容 zinit 安装的 ranger.py
# function ranger.py {
#     local IFS=$'\t\n'
#     local tempfile="$(mktemp -t tmp.XXXXXX)"
#     local ranger_cmd=(
#         command
#         ranger.py
#         --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
#     )
#     
#     ${ranger_cmd[@]} "$@"
#     if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
#         cd -- "$(cat "$tempfile")" || return
#     fi
#     command rm -f -- "$tempfile" 2>/dev/null
# }
# if builtin command -v ranger.py > /dev/null 2>&1 ; then
#     unset -f ranger
# else
#     unset -f ranger.py
# fi

# delta 改进 git 的预览
zinit ice lucid wait"2" from"gh-r" as"program" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta

# jq 是一个简单的 JSON 解析器
# zinit ice lucid wait"1" lucid from"gh-r" as"program" mv"jq-* -> jq" pick"jq"
# zinit light stedolan/jq

# neovim 是一个终端编辑器 （和 vim 类似）
# zinit ice lucid wait"1" from"gh-r" ver"nightly" as"program" \
#                     mv"nvim-* -> nvim" \
#                     bpick"*linux*" \
#                     pick"nvim/bin/nvim"
# zinit light neovim/neovim

# zoxide 是路径快速跳转工具，类似的有 z，autojump，z.lua 等
# zinit ice lucid wait from"gh-r" as"program" \
#                     pick"zoxide/zoxide" \
#                     atload'eval "$(zoxide init --no-aliases zsh)"'
# zinit light ajeetdsouza/zoxide

# 应用程序 结束 -----------

# Plugins
# 需要安装 jq 处理 json 数据
# 下面插件见 readme.md
# 安装自定义插件可以按照下面的方式安装
zinit wait"1" lucid depth"1" light-mode for \
  brymck/print-alias \
  djui/alias-tips \

zinit wait lucid depth'1' for \
  as"program" pick"bin/git-fuzzy" bigH/git-fuzzy \
                                  lukechilds/zsh-nvm \
  atload"zicompinit; zicdreplay"  Aloxaf/fzf-tab \
  # atload"_zsh_autosuggest_start"  zsh-users/zsh-autosuggestions \
  #                                 zdharma-continuum/fast-syntax-highlighting
  #NOTE: 上面这段是说延迟启动，除非有命令调用它，由于这两个插件比较重要，默认需要直接启动

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

#HACK: pixi预览
zsh-defer -c 'eval "$(pixi completion --shell zsh)"'
# zsh-defer -c 'eval "$(atuin init zsh)"'
