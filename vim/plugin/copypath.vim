" copypath.vim - copy current file path
" Maintainer: Phong Nguyen <nhphong1406@gmail.com>
" Version: 0.1.0

if get(g:, 'loaded_vim_copypath', 0)
    finish
endif

" Copy path to clipboard
function! s:copy_path_to_clipboard(path)
    let @" = a:path
    if has('clipboard')
        let [@*, @+] = [@", @"]
    endif
    echo 'Copied: ' . @"
endfunction

function! s:copy_path(path, line)
    let path = expand(a:path)
    if a:line
        let path .= ':' . line('.')
    endif
    call s:copy_path_to_clipboard(path)
endfunction

command! -bang CopyRelativePath call <SID>copy_path('%', <bang>0)
command! -bang CopyFullPath     call <SID>copy_path('%:p', <bang>0)
command! -bang CopyParentPath   call <SID>copy_path(<bang>0 ? '%:p:h' : '%:h', 0)

if get(g:, 'vim_copypath_mappings', 1)
    nnoremap <silent> yrp :CopyRelativePath<CR>
    nnoremap <silent> yRP :CopyRelativePath!<CR>
    nnoremap <silent> yfp :CopyFullPath<CR>
    nnoremap <silent> yFP :CopyFullPath!<CR>
    nnoremap <silent> ypp :CopyParentPath<CR>
    nnoremap <silent> yPP :CopyParentPath!<CR>
endif

let g:loaded_vim_copypath = 1
