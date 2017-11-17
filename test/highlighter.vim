"==========================================================
" test/highlighter.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

let s:suite = themis#suite('highlighter')
let s:assert = themis#helper('assert')

let s:colorscheme = tempname()


function! s:suite.before_each() abort
    call highlighter#init()
endfunction


function! s:suite.init() abort
    call s:assert.equals(highlighter#rule#get(), {})
endfunction


function! s:suite.define_single() abort
    call highlighter#define('Normal', {'fg': 0})

    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 0}})
endfunction


function! s:suite.define_multiple() abort
    let rule = {'Normal': {'fg': 0, 'bg': 1}, 'Special': {'fg': 2, 'bg': 3}}
    call highlighter#define(rule)

    call s:assert.equals(highlighter#rule#get(), rule)
endfunction


function! s:suite.define_override_keep() abort
    call highlighter#define('Normal', {'fg': 0})
    call highlighter#define('Normal', {'fg': 1})

    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 0}})
endfunction


function! s:suite.define_override_force() abort
    call highlighter#define('Normal', {'fg': 0})
    call highlighter#define('Normal', {'fg': 1}, 1)

    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 1}})
endfunction


function! s:suite.generate_file() abort
    call highlighter#define('Normal', {'bg': 0, 'fg': 1})
    call highlighter#define('Special', {'bg': 2, 'fg': 3})

    call highlighter#cache(s:colorscheme)
    call s:assert.equals(filereadable(s:colorscheme), 1)
endfunction
