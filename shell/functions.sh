_include() {
    [ -f "$1" ] && source "$1"
}

random_string() {
    local cnt
    cnt=17
    if [ -n "$1" ]; then
        cnt=$1
    else
        echo "generate random string with default length: $cnt"
    fi
    </dev/urandom tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | head -c $cnt  ; echo
}

search_in_file() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" \
        | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

reload_shell() {
    # TODO: check is there is bg cmd?
    exec -l $SHELL
}
