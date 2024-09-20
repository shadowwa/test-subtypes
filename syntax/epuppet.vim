if (exists('g:debug_test_subtype'))
    echom 'entering ' . expand('<sfile>')
endif

" since this filetype can be loaded along a subtype, don't test with b:current_syntax
if (exists('b:current_syntax') && b:current_syntax ==# 'epuppet')
    if (exists('g:debug_test_subtype'))
        echom "b:current_syntax existing '". b:current_syntax ."', skiping"
    endif
    finish
endif

if (exists('g:debug_test_subtype'))
    echom 'stack: ' . expand('<stack>')
endif
syn region epuppetBlock start="<%%\@!-\=" end="[=-]\=%\@<!%>"

hi def epuppetBlock term=bold ctermfg=159 guifg=Cyan

let b:current_syntax = 'epuppet'
