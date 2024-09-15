if (exists('g:debug_test_subtype'))
    echom 'entering ' . expand('<sfile>')
endif

" since this filetype can be loaded along a subtype, don't test with b:did_ftplugin
if (exists('b:did_ftplugin_outer'))
    if (exists('g:debug_test_subtype'))
        echom 'b:did_ftplugin_outer existing, skiping'
    endif
    finish
endif

" add ftplugin stuff
"
let b:did_ftplugin_outer = 1

if (exists('g:debug_test_subtype'))
    echom 'stack: ' . expand('<stack>')
endif
