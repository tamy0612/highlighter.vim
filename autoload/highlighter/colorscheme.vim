"==========================================================
" autoload/highlighter/colorscheme.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

function! highlighter#colorscheme#get()
    return get(s:, 'colorscheme', '')
endfunction


function! highlighter#colorscheme#set(colorscheme)
    let s:colorscheme = a:colorscheme
endfunction


function! highlighter#colorscheme#clear()
    unlet! s:colorscheme
endfunction


function! highlighter#colorscheme#command()
    if exists('s:colorscheme')
        return 'colorscheme ' . s:colorscheme
    endif
    return '" No base colorscheme'
endfunction
