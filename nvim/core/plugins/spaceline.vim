if has('unix')
    if has('mac')
        " FIXME: the repo does not contains the colorscheme solarized_dark any
        " more, change color scheme or change status line plugin?
        let g:spaceline_colorscheme = 'solarized_dark'
        if g:is_terminal_recording
            " gui color can not work well when asciinema recording
            let g:spaceline_colorscheme = 'base16_dark'
        endif
    else
        let g:spaceline_colorscheme = 'space'
    endif
endif

let g:spaceline_seperate_style= 'none'
