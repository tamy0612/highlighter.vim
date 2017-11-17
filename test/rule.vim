"==========================================================
" test/rule.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

let s:suite = themis#suite('rule')
let s:assert = themis#helper('assert')


function! s:suite.before_each() abort
    call highlighter#rule#clear()
endfunction

function! s:suite.rule_get() abort
    call s:assert.equals(highlighter#rule#get(), {})
endfunction

function! s:suite.rule_add_simple() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2}, 0)
    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 1, 'bg': 2}})
endfunction

function! s:suite.rule_add_dup() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2}, 0)
    call highlighter#rule#add('Normal', {'fg': 3, 'bg': 4}, 0)
    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 1, 'bg': 2}})
endfunction

function! s:suite.rule_add_dup() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2}, 0)
    call highlighter#rule#add('Normal', {'fg': 3, 'bg': 4}, 1)
    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 3, 'bg': 4}})
endfunction

function! s:suite.rule_clear() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2}, 0)
    call highlighter#rule#add('Special', {'fg': 3, 'bg': 4}, 0)
    call highlighter#rule#clear('Normal')
    call s:assert.equals(highlighter#rule#get(), {'Special': {'fg': 3, 'bg': 4}})
endfunction

function! s:suite.rule_clear_all() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2}, 0)
    call highlighter#rule#add('Special', {'fg': 3, 'bg': 4}, 0)
    call highlighter#rule#clear()
    call s:assert.equals(highlighter#rule#get(), {})
endfunction
