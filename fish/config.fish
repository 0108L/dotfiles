function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
end

set -x PATH /usr/local/texlive/2024/bin/x86_64-linux /home/jc/.config/emacs/bin $PATH
set -x MANPATH /usr/local/texlive/2024/texmf-dist/doc/man $MANPATH
set -x INFOPATH /usr/local/texlive/2024/texmf-dist/doc/info $INFOPATH

atuin init fish | source
starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end

#list
alias ls='lsd'
alias la='ls -a'
alias ll='ls -alFh'
alias lla='ls -la'
alias lt='ls -tree'
alias l='ls -l'
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"
alias exa='exa -lh'
alias mkdir='mkdir -p'

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

# Aliases for software managment
# pacman
alias pacman="sudo pacman --color auto"
alias update="sudo pacman -Syyu"
alias upd="sudo pacman -Syyu"
alias yay="yay --color auto"

#pacman
alias sps='sudo pacman -S'
alias spr='sudo pacman -R'
alias sprs='sudo pacman -Rs'
alias sprdd='sudo pacman -Rdd'
alias spqo='sudo pacman -Qo'
alias spsii='sudo pacman -Sii'

#fix obvious typo's
alias pdw='pwd'
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'
alias updte='sudo pacman -Syyu'
alias updqte='sudo pacman -Syyu'
alias upqll='paru -Syu --noconfirm'
alias upal='paru -Syu --noconfirm'

# source ~/.config/fish/aliases.fish

thefuck --alias | source
