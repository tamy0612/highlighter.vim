"==========================================================
" test/highlighter.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 16 Nov. 2017.
"==========================================================

let s:suite = themis#suite('highlighter')
let s:assert = themis#helper('assert')

let s:colorscheme = expand('<sfile>:p:h') . '/../colors/highlighter.vim'


function! s:suite.before_each() abort
    call highlighter#init('default')
    call highlighter#define('Normal', {'bg': 0, 'fg': 1})
    call highlighter#define('Special', {'bg': 2, 'fg': 3})

    call highlighter#write(s:colorscheme)
endfunction


function! s:suite.generate_file() abort
    call s:assert.equals(filereadable(s:colorscheme), 1)
endfunction
