"==========================================================
" autoload/highlighter/rule.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

function! highlighter#rule#get(...) abort
    if !exists('s:rules')
        let s:rules = {}
    endif

    return s:rules
endfunction


function! highlighter#rule#add(tag, dict, bang) abort
    let rules = highlighter#rule#get()
    if highlighter#rule#_defined(a:tag)
        let override = ['keep', 'force'][a:bang]
        call extend(rules[a:tag], a:dict, override)
    else
        let rules[a:tag] = a:dict
    endif
    return 1
endfunction


function! highlighter#rule#clear(...) abort
    if empty(a:000) && exists('s:rules')
        unlet s:rules
    else
        let rules = highlighter#rule#get()
        for tag in a:000
            if highlighter#rule#_defined(tag)
                call remove(rules, tag)
            else
                call highlighter#helper#error("'" . tag . "' is not a registered key")
            endif
        endfor
    endif
endfunction


function! highlighter#rule#_defined(tag) abort
    let rules = highlighter#rule#get()
    return has_key(rules, a:tag)
endfunction
