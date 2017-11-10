"==========================================================
" autoload/highlighter/rule.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 15 Nov. 2017.
"==========================================================

function! highlighter#rule#get(...) abort
    if !exists('s:rules')
        let s:rules = {}
    endif

    return s:rules
endfunction


function! highlighter#rule#defined(tag) abort
    let rules = highlighter#rule#get()
    return has_key(rules, a:tag)
endfunction


function! highlighter#rule#add(tag, dict) abort
    let rules = highlighter#rule#get()
    if has_key(rules, a:tag)
        call extend(rules[a:tag], a:dict)
    else
        let rules[a:tag] = a:dict
    endif
    return 1
endfunction


function! highlighter#rule#clear(...) abort
    if empty(a:000) && exists('s:rules')
        unlet s:rules
    else
        for tag in a:000
            try
                let rules = highlighter#rule#get()
                call remove(rules, tag)
            catch
                call highlighter#helper#error("'" . tag . "' is not a registered key")
                return 0
            endtry
        endfor
    endif
    return 1
endfunction
