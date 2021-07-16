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
let s:yelow   = "#e6db74"
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
if &transparent
  let s:Background = NONE
endif

" Definition of the color theme
let g:Theme = {
\
\}

call kaivim#Sync()


augroup kaivim
  autocmd!
  autocmd Syntax * call kaivim#Sync()
  autocmd Colorscheme *
    \ if g:colors_name !=# 'kaivim'
    \ | autocmd! kaivim 
    \ | endif
augroup END
