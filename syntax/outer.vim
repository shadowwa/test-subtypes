if (exists('g:debug_test_subtype'))
    echom 'entering ' . expand('<sfile>')
endif

" since this filetype can be loaded along a subtype, don't test with b:current_syntax
if (exists('b:current_syntax') && b:current_syntax ==# 'outer')
    if (exists('g:debug_test_subtype'))
        echom "b:current_syntax existing '". b:current_syntax ."', skiping"
    endif
    finish
endif

if (exists('g:debug_test_subtype'))
    echom 'stack: ' . expand('<stack>')
endif
syn region outerBlock start="<%%\@!-\=" end="[=-]\=%\@<!%>"

hi def outerBlock term=standout ctermfg=121 gui=bold guifg=Green

let b:current_syntax = 'outer'
