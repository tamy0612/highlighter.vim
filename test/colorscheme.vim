"==========================================================
" test/colorscheme.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

let s:suite = themis#suite('colorscheme')
let s:assert = themis#helper('assert')


function! s:suite.before_each() abort
    call highlighter#colorscheme#clear()
endfunction


function! s:suite.get() abort
    call s:assert.equals(highlighter#colorscheme#get(), '')
endfunction


function! s:suite.set() abort
    call highlighter#colorscheme#set('default')

    call s:assert.equals(highlighter#colorscheme#get(), 'default')
endfunction


function! s:suite.clear() abort
    call highlighter#colorscheme#set('default')
    call highlighter#colorscheme#clear()

    call s:assert.equals(highlighter#colorscheme#get(), '')
endfunction


function! s:suite.command() abort
    call highlighter#colorscheme#set('default')

    call s:assert.equals(highlighter#colorscheme#command(), 'colorscheme default')
endfunction


function! s:suite.command_empty() abort
    call s:assert.equals(highlighter#colorscheme#command(), '" No base colorscheme')
endfunction
