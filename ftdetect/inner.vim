if (exists('g:debug_test_subtype'))
    echom 'detecting filetype in ' . expand('<sfile>')
endif
au BufNewFile,BufRead *.inner		setf inner
