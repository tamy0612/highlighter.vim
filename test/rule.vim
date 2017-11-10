"==========================================================
" test/rule.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 15 Nov. 2017.
"==========================================================

let s:suite = themis#suite('rule')
let s:assert = themis#helper('assert')


function! s:suite.before_each() abort
    call highlighter#rule#clear()
endfunction

function! s:suite.rule_get() abort
    call s:assert.equals(highlighter#rule#get(), {})
endfunction

function! s:suite.rule_add() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2})
    call s:assert.equals(highlighter#rule#get(), {'Normal': {'fg': 1, 'bg': 2}})
endfunction

function! s:suite.rule_clear() abort
    call highlighter#rule#add('Normal', {'fg': 1, 'bg': 2})
    call highlighter#rule#add('Special', {'fg': 3, 'bg': 4})
    call highlighter#rule#clear('Normal')
    call s:assert.equals(highlighter#rule#get(), {'Special': {'fg': 3, 'bg': 4}})
endfunction
