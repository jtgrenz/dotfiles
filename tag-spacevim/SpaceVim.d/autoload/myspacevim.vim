function! myspacevim#before() abort
  " ====== General ======
  set colorcolumn=80,120

  " Treat long lines as break lines (useful when moving around in them)
  map j gj
  map k gk

  " Open splits below and to the right
  set splitbelow
  set splitright

  " ====== Key Maps ======
  " Copy to the selection to the clipboard
  noremap <leader>y "+y
  " Copy entire file to clipboard
  nnoremap <leader>gy gg"+yG

endfunction

function! myspacevim#after() abort
  " call SpaceVim#mapping#space#def('nnoremap', ['f', 'c'], 'LeaderfTag', 'search ctags', 1)
endfunction


