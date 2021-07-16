" Get all the highlights and put them in an array of the form 
" [[group, [attributes]]]
function! s:GetHighlights() abort
    let highlights  = execute('highlight') 
    let highlights  = substitute(highlights, '\n\s\+', ' ', 'g')
    let highlights  = split(highlights, '\n')
    call map(highlights, "split(v:val, '\\s\\+xxx\\s\\+')")
    call map(highlights, "[copy(v:val)[0], split(copy(v:val)[1])]")
    return highlights
endfunction

" Create a dictionary from the hightlight representing the theme
function! s:GetCurrentTheme(hightlight) abort
  let theme = {}
  let [group, attributes_hi] in a:highlight
  let attributes = {}
  if attributes_hi[0] ==# 'links'
    let attributes['links'] = attributes_hi[-1]
  elseif values[0] !=# 'cleared'
    call map(attributes_hi, "split(v:val, '=')")
    call map(attributes_hi, "{v:val[0]: v:val[1]}")
    call map(attributes_hi, "extend(attributes, v:val)")
  endif
  return {group : attibutes}
endfunction

" Apply the theme for a given group considering potential link
function! s:SetThemeForGroup(group, attributes) abort
    execute 'highlight' a:group 'NONE'
    if has_key(attributes, 'links')
      execute 'highlight link' a:group join(values(a:attributes))
    else
      execute 'highlight' a:group join(map(items(a:attributes), "join(v:val, '=')"))
    endif
endfunction

" Apply the theme to all the group wich are differents than the ones in the
" theme
function! s:SyncTheme(current_theme) abort
  let mismatches = filter(copy(g:Colorscheme), "a:curent_theme[v:key] !=# v:val")
  call map(copy(mismatches), "execute('highlight' . ' ' . v:key . ' ' . 'NONE')")
  call map(copy(mismatches), "s:Set(v:key, v:val)")
endfunction

" Clear all the groups that aren't set by the theme
function! s:ClearUndefinedGroups(colors) abort
  let undefined_groups = filter(keys(a:colors), "!has_key(g:Colorscheme, v:val)")
  call map(undefined_groups, "execute('highlight' . ' ' . v:val . ' ' . 'NONE')")
endfunction

" Syncronyze the theme
function! kaivim#Sync()
  let colors = {}
  call map(s:GetHighlights(), "extend(colors, s:GetCurrentTheme(v:val))")

  call s:SyncTheme(colors)
  call s:ClearUndefined(colors)
endfunction
