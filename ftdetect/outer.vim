" vint: -ProhibitAutocmdWithNoGroup

if (exists('g:debug_test_subtype'))
    echom 'detecting filetype in ' . expand('<sfile>')
endif

"au BufNewFile,BufRead *.outer		setf outer

" finding multiple file extention
"let g:outer_default_subtype = 'sh'
" TODO maybe add a! if already declared in filetype.vim?
"au BufNewFile,BufRead *.outer call DetectSubOuterExtensionType()
function! DetectSubOuterExtensionType()
    " TODO barrier for when filetype already detected? happen with nvim 10.1
    "echom "current filetype:" . &filetype
    " TODO find use case of this one
    "let b:outer_subtype = matchstr(&filetype,'^outer\.\zs\w\+')
    "echom "subtype detected as " . b:outer_subtype
    let b:outer_subtype = matchstr(substitute(expand('%:t'),'\c\%(\.outer\)\+$','',''),'\.\zs\w\+\%(\ze+\w\+\)\=$')
    if (exists('g:debug_test_subtype'))
        echom 'subtype detected as ' . b:outer_subtype
        echom 'stack: ' . expand('<stack>')
    endif

    if b:outer_subtype ==? 'rhtml'
        let b:outer_subtype = 'html'
    elseif b:outer_subtype ==? 'rb'
        let b:outer_subtype = 'ruby'
    elseif b:outer_subtype ==? 'yml'
        let b:outer_subtype = 'yaml'
    elseif b:outer_subtype ==? 'js'
        let b:outer_subtype = 'javascript'
    elseif b:outer_subtype ==? 'txt'
        " Conventional; not a real file type
        let b:outer_subtype = 'text'
    elseif b:outer_subtype ==? 'py'
        let b:outer_subtype = 'python'
    elseif b:outer_subtype ==? 'rs'
        let b:outer_subtype = 'rust'
    elseif b:outer_subtype ==? 'epp'
        let b:outer_subtype = 'epuppet'
    elseif b:outer_subtype ==? ''
        let b:outer_subtype = g:outer_default_subtype
    endif

    if exists('b:outer_subtype') && b:outer_subtype !=? '' && b:outer_subtype !=? 'outer'
        "exe "setf " . b:outer_subtype . ".outer"
        "exe "setlocal filetype=" . b:outer_subtype . ".outer"
        if (exists('g:debug_test_subtype'))
            echom ' setting to ' . b:outer_subtype . '.outer'
        endif
        let &filetype = b:outer_subtype . '.outer'
    else
        if (exists('g:debug_test_subtype'))
            echom ' setting to outer'
        endif
        setf outer
    endif
    unlet b:outer_subtype

endfunction

" autodetect inner file
" -> only detect and apply inner file, does not work with nvim and file
"  already existing in filetype.lua?
"au BufNewFile,BufRead *.outer
"	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))

" TODO detect removing outer extention and play filetype detect again
au BufNewFile,BufRead *.outer call DetectSubOuterNativeType()
function! DetectSubOuterNativeType()
    if exists('*fnameescape')
"        echom 'FILETYPE before:' . &filetype
        execute 'doautocmd filetypedetect BufRead ' .fnameescape(expand('<afile>:r'))
"        echom 'FILETYPE autodetect by vim:' . &filetype
        if &filetype =~# 'outer'
            return
        endif
        if &filetype !=# '' && !( &filetype ==# 'mason' && expand('<afile>') !~# 'mason')
            let b:outer_subtype = &filetype
            if (exists('g:debug_test_subtype'))
                echom ' setting to ' . b:outer_subtype . '.outer'
            endif
            let &filetype = b:outer_subtype . '.outer'
        else
            if (exists('g:debug_test_subtype'))
                echom ' setting to outer'
            endif
            if exists('g:outer_default_subtype') && g:outer_default_subtype !=# ''
                let &filetype = g:outer_default_subtype . '.outer'
            else
                let &filetype = 'outer'
                " test setf outer
            endif
        endif
    elseif &verbose > 0
        echomsg 'Warning: outer subtype will not be recognized because this version of Vim does not have fnameescape()'
        setf outer
    endif
endfunction
