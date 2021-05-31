if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='gls --color=auto'
    alias ll='gls -alFh --color=auto'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto'
    alias ll='ls -alFh --color=auto'
fi

alias cat='bat --theme=TwoDark'
alias pcat='bat --theme=TwoDark --style=plain'

# alias pftp='ftp -p'

# alias grep='grep --color=auto'

alias vi="${VIM_BIN}"
alias vim="${VIM_BIN}"
alias nvim="${VIM_BIN}"

alias scheme='rlwrap scheme'

alias asciinema_record='asciinema rec -i 1.5 -c "IS_TERMINAL_RECORDING=asciinema zsh"'

# alias lldb='PATH=/usr/bin lldb'

# print Chinese characters
alias tree='tree -N'
