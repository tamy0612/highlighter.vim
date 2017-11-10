"==========================================================
" autoload/highlighter.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 15 Nov. 2017.
"==========================================================

function! highlighter#init(...) abort
    let cscheme = get(a:000, 0, '')
    if cscheme != ''
        let s:highlighter_default_colorscheme = cscheme
    endif
endfunction


function! highlighter#define(...) abort
    " try
        if type(a:1) == v:t_dict
            let bang = get(a:000, 2, 0)
            return s:define_highlight_all(a:1, bang)
        elseif type(a:1) == v:t_string && type(a:2) == v:t_dict
            let bang = get(a:000, 3, 0)
            return s:define_highlight(a:1, a:2, bang)
        endif
    " catch
    "     echomsg highlighter#helper#error('Invalid argumants: highlighter#define(' . join(a:000, ", ") . ')')
    " endtry
    return 1
endfunction


function! highlighter#write(filename) abort
    let dir = fnamemodify(a:filename, ':p:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
    execute 'redir! > ' . a:filename
        if exists('s:highlighter_default_colorscheme')
            silent echo 'colorscheme ' . s:highlighter_default_colorscheme
        endif
        let rules = highlighter#rule#get()
        for tag in keys(rules)
            silent echo highlighter#command#highlight(tag, rules[tag])
        endfor
    redir END
endfunction


function! highlighter#apply() abort
    let filename = tempname()
    call highlighter#write(filename)
    execute 'source ' . filename
endfunction


function! s:define_highlight(tag, dict, bang) abort
    if a:bang && highlighter#rule#defined(a:tag)
        call highlighter#rule#clear(a:tag)
    endif
    return highlighter#rule#add(a:tag, a:dict)
endfunction


function! s:define_highlight_all(dict, bang) abort
    for tag in keys(a:dict)
        call s:define_highlight(tag, a:dict[tag], a:bang)
    endfor
    return 1
endfunction
