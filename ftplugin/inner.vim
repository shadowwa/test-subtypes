if (exists('g:debug_test_subtype'))
    echom 'entering ' . expand('<sfile>')
endif

if (exists('b:did_ftplugin'))
    if (exists('g:debug_test_subtype'))
        echom 'b:did_ftplugin existing, skiping'
    endif
    finish
endif

" add ftplugin stuff

let b:did_ftplugin = 1

if (exists('g:debug_test_subtype'))
    echom 'stack: ' . expand('<stack>')
endif
