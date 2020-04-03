let g:spaceline_colorscheme = 'solarized_dark'
if g:is_asciinema_recording
    " gui color can not work well when asciinema recording
    let g:spaceline_colorscheme = 'base16_dark'
endif

let g:spaceline_seperate_style= 'none'
