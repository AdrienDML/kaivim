" Get all the highlights and put them in an array of the form 
" [[group, [attributes]]]
function s:GetHighlights() abort
    let highlights  = execute('highlight') 
    let highlights  = substitute(highlights, '\n\s\+', ' ', 'g')
    let highlights  = split(highlights, '\n')
    call map(highlights, "split(v:val, '\\s\\+xxx\\s\\+')")
    call map(highlights, "[copy(v:val)[0], split(copy(v:val)[1])]")
    return highlights
endfunction

" Create a dictionary from the hightlight representing the theme
function! s:GetCurrentTheme() abort
  let theme = {}
  for [group, values] in <SID>GetHighlights()
    let attributes = {}
    if values[0] ==# 'links'
      let attributes['links'] = values[-1]
    elseif values[0] !=# 'cleared'
      call map(values, "split(v:val, '=')")
      call map(values, "{v:val[0]: v:val[1]}")
      call map(values, "extend(attributes, v:val)")
    endif
    let theme[group] = attributes
  endfor
  return theme
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
  for [group, attributes] in items(g:Colorscheme)
    if attributes !=# a:current_theme[group]
      call <SID>SetColors({group: attributes})
    endif
  endfor
endfunction

" Clear all the groups that aren't set by the theme
function! s:ClearUndefinedGroups(colors) abort
  let undefined_groups = filter(keys(a:colors), "!has_key(g:Colorscheme, v:val)")
  call map(undefined_groups, "execute('highlight' . ' ' . v:val . ' ' . 'NONE')")
endfunction

" Syncronyze the theme
function! kaivim#Sync()
  let current_theme = <SID>GetCurrentTheme()
  call <SID>SyncTheme(current_theme)
  call <SID>ClearUndefinedGroups(current_theme)
endfunction
