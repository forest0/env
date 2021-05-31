export LANG=en_US.UTF-8

# golang
export GO111MODULE=on
export GOPATH=~/workspace/go
export PATH=$PATH:$GOPATH/bin

export EDITOR=nvim

export PATH=$PATH:/usr/local/sbin

if [[ "$OSTYPE" == "darwin"* ]]; then
    # tex
    export PATH=$PATH:/usr/local/texlive/2020basic/bin/x86_64-darwin

    # search /usr/local/bin first
    export PATH="/usr/local/bin:$PATH"

    # use gnu bin
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # It is ok to use global proxy, since mellow will route traffic properly.
    # Although mellow use a tun by default(which will take over all traffic
    # transparently), it has a performance problem.
    #
    # TODO: check port available
    export http_proxy="http://127.0.0.1:7890/"
    export https_proxy="${http_proxy}"
fi

export PATH="${PATH}:${HOME}/.iterm2"
