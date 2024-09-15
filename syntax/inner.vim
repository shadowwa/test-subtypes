if (exists('g:debug_test_subtype'))
    echom 'entering ' . expand('<sfile>')
endif

if (exists('b:current_syntax'))
    if (exists('g:debug_test_subtype'))
        echom "b:current_syntax existing '". b:current_syntax ."', skiping"
    endif
    finish
endif

if (exists('g:debug_test_subtype'))
    echom 'stack: ' . expand('<stack>')
endif
syn region  innerComment       start="/\*" end="\*/"

hi def InnerComment term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red

let b:current_syntax = 'inner'
