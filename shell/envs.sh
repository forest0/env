export LANG=en_US.UTF-8

# golang
export GO111MODULE=on
export GOPATH=~/workspace/go
export PATH=$PATH:$GOPATH/bin

# tex
export PATH=$PATH:/usr/local/texlive/2019basic/bin/x86_64-darwin

export EDITOR=nvim

export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

# search /usr/local/bin first
export PATH="/usr/local/bin:$PATH"

# use gnu bin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# It is ok to use global proxy, since mellow will route traffic properly.
# Although mellow use a tun by default(which will take over all traffic
# transparently), it has a performance problem.
#
# TODO: check port available
export http_proxy=http://127.0.0.1:2885/
export https_proxy=http://127.0.0.1:2885/
