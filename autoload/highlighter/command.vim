"==========================================================
" autoload/highlighter/command.vim
"
" Author: Yasumasa TAMURA (tamura.yasumasa@gmail.com)
" Last Change: 15 Nov. 2017.
"==========================================================

function! highlighter#command#highlight(tag, dict) abort
    if has_key(a:dict, 'link')
        return join(['highlight', 'link', a:tag, a:dict.link], ' ')
    endif
    return join(['highlight', a:tag, s:parse_options(a:dict)], ' ')
endfunction


function! s:parse_options(dict) abort
    let options = s:normalize(a:dict)
    let given = filter(options, 'v:val!=""')
    return join(values(map(given, 'v:key . "=" . v:val')), ' ')
endfunction


function! s:normalize(dict) abort
    let fg = get(a:dict, 'fg', '')
    let bg = get(a:dict, 'bg', '')
    let em = get(a:dict, 'em', '')
    let gfg = highlighter#gui#xterm(fg)
    let gbg = highlighter#gui#xterm(bg)
    let candidates = {
                \ 'ctermfg': get(a:dict, 'ctermfg', fg),
                \ 'ctermbg': get(a:dict, 'ctermbg', bg),
                \ 'cterm':   get(a:dict, 'cterm',   em),
                \ 'guifg':   get(a:dict, 'guifg',   gfg),
                \ 'guibg':   get(a:dict, 'guibg',   gbg),
                \ 'gui':     get(a:dict, 'gui',     em),
                \ 'guisp':   get(a:dict, 'guisp',   ''),
                \ 'font':    get(a:dict, 'font',    '')
                \}
    return candidates
endfunction
