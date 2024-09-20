" vint: -ProhibitAutocmdWithNoGroup

if (exists('g:debug_test_subtype'))
    echom 'detecting filetype in ' . expand('<sfile>')
endif

"au BufNewFile,BufRead *.epuppet		setf epuppet

" finding multiple file extention
let g:epuppet_default_subtype = 'sh'
" TODO maybe add a! if already declared in filetype.vim?
au BufNewFile,BufRead *.epp call DetectSubEPuppetExtensionType()
function! DetectSubEPuppetExtensionType()
    " TODO barrier for when filetype already detected? happen with nvim 10.1
    "echom "current filetype:" . &filetype
    " TODO find use case of this one
    "let b:epuppet_subtype = matchstr(&filetype,'^epuppet\.\zs\w\+')
    "echom "subtype detected as " . b:epuppet_subtype
    let b:epuppet_subtype = matchstr(substitute(expand('%:t'),'\c\%(\.epp\)\+$','',''),'\.\zs\w\+\%(\ze+\w\+\)\=$')
    if (exists('g:debug_test_subtype'))
        echom 'subtype detected as ' . b:epuppet_subtype
        echom 'stack: ' . expand('<stack>')
    endif

    if b:epuppet_subtype ==? 'rhtml'
        let b:epuppet_subtype = 'html'
    elseif b:epuppet_subtype ==? 'rb'
        let b:epuppet_subtype = 'ruby'
    elseif b:epuppet_subtype ==? 'yml'
        let b:epuppet_subtype = 'yaml'
    elseif b:epuppet_subtype ==? 'js'
        let b:epuppet_subtype = 'javascript'
    elseif b:epuppet_subtype ==? 'txt'
        " Conventional; not a real file type
        let b:epuppet_subtype = 'text'
    elseif b:epuppet_subtype ==? 'py'
        let b:epuppet_subtype = 'python'
    elseif b:epuppet_subtype ==? 'rs'
        let b:epuppet_subtype = 'rust'
    elseif b:epuppet_subtype ==? ''
        let b:epuppet_subtype = g:epuppet_default_subtype
    endif

    if exists('b:epuppet_subtype') && b:epuppet_subtype !=? '' && b:epuppet_subtype !=? 'epuppet'
        "exe "setf " . b:epuppet_subtype . ".epuppet"
        "exe "setlocal filetype=" . b:epuppet_subtype . ".epuppet"
        if (exists('g:debug_test_subtype'))
            echom ' setting to ' . b:epuppet_subtype . '.epuppet'
        endif
        let &filetype = b:epuppet_subtype . '.epuppet'
    else
        if (exists('g:debug_test_subtype'))
            echom ' setting to epuppet'
        endif
        setf epuppet
    endif
    unlet b:epuppet_subtype

endfunction

" autodetect inner file
" -> only detect and apply inner file, does not work with nvim and file
"  already existing in filetype.lua?
"au BufNewFile,BufRead *.epuppet
"	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))

" TODO detect removing epuppet extention and play filetype detect again
