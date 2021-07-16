" Theme name
let g:colors_name='kaivim'

" Theme color palette
let s:white   = "#f8f8f2"
let s:black   = "#272822"
let s:red     = "#f92672"
let s:green   = "#a6e22e"
let s:cyan    = "#a1efe4"
let s:blue    = "#66d9ef"
let s:violet  = "#ae81ff"
let s:magenta = "#fd5ff0"
let s:yellow   = "#e6db74"
let s:orange  = "#fd971f"
let s:grey    = "#75715e"

" Chose between light and dark theme
if &background ==# 'light'
  let s:Foreground = s:black
  let s:Background = s:white
elseif &background ==# 'dark'
  let s:Foreground = s:white
  let s:Background = s:black
endif

" Change the backgroun to none for transparent theme
if g:transparent
  let s:Background = 'NONE'
endif
 

" Definition of the color theme
let g:Colorscheme = {
  \ 'Normal'        : { 'guifg' : s:white},
  \ 'Comment'       : { 'guifg' : s:grey},
  \ 'PreProc'       : { 'guifg' : s:white},
  \ 'String'        : { 'guifg' : s:yellow},
  \ 'Statement'     : { 'guifg' : s:red},
  \ 'Keyword'       : { 'guifg' : s:red},
  \ 'Boolean'       : { 'guifg' : s:violet},
  \ 'Todo'          : { 'guifg' : s:orange},
  \ 'Function'      : { 'guifg' : s:green},
  \ 'Operator'      : { 'guifg' : s:red},
  \ 'Type'          : { 'guifg' : s:blue},
  \ 'Number'        : { 'guifg' : s:violet},
  \ 'Delimiter'     : { 'guifg' : s:white},
  \}

call kaivim#Sync()


augroup Kaivim
  autocmd!
  autocmd Syntax * call kaivim#Sync()
  autocmd Colorscheme *
    \ if g:colors_name !=# 'kaivim'
    \ | autocmd! Kaivim 
    \ | endif
augroup END
