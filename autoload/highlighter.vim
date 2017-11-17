"==========================================================
" autoload/highlighter.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 17 Nov. 2017.
"==========================================================

if v:version < 800 && !has('nvim')
    let s:type_dict = type({})
    let s:type_string = type('')
else
    let s:type_dict = v:t_dict
    let s:type_string = v:t_string
endif


function! highlighter#init(...) abort
    call highlighter#rule#clear()
    call highlighter#colorscheme#clear()
    let cscheme = get(a:000, 0, '')
    if cscheme != ''
        call highlighter#colorscheme#set(cscheme)
    endif
endfunction


function! highlighter#base(cscheme) abort
    call highlighter#colorscheme#set(cscheme)
endfunction


function! highlighter#define(...) abort
    let args = s:parse(a:000)
    for tag in keys(args.rules)
        call s:define_highlight(tag, args.rules[tag], args.bang)
    endfor
endfunction


function! highlighter#cache(filename) abort
    let dir = fnamemodify(a:filename, ':p:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
    execute 'redir! > ' . a:filename
        silent echo highlighter#colorscheme#command()
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


function! s:parse(args) abort
    if type(a:args[0]) == s:type_dict
        return {'rules': a:args[0], 'bang': get(a:args, 1, 0)}
    elseif type(a:args[0]) == s:type_string && type(a:args[1]) == s:type_dict
        let rule = {}
        let rule[a:args[0]] = a:args[1]
        return {'rules': rule, 'bang': get(a:args, 2, 0)}
    else
        throw highlighter#helper#error('Invalid argumants')
    endif
    return {'rules': {}, 'bang': 0}
endfunction


function! s:define_highlight(tag, dict, bang) abort
    call highlighter#rule#add(a:tag, a:dict, a:bang)
endfunction
