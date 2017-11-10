"==========================================================
" autoload/highlighter/helper.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 13 Nov. 2017.
"==========================================================

let s:label = '[highlighter]'


function! highlighter#helper#message(msg) abort
    echomsg s:concat(s:label, a:msg)
endfunction


function! highlighter#helper#error(msg) abort
    echomsg s:concat(s:label, "Error:", a:msg)
endfunction


function! s:concat(...)
    return join(a:000, " ")
endfunction
