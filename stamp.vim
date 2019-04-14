" Create Stamp (S) operator
vnoremap <silent> S :call VisualStamp(visualmode())<CR>
nnoremap <silent> S :set opfunc=MotionStamp<CR>g@

" Stamps the current selection in visual mode.
function! VisualStamp(mode) range

  " Ignore Ignore visual visual selection unless it's line-wise or character-wise.
  if a:mode !=# 'V' && a:mode !=# 'v'
    return
  endif

  " When in character-wise visual mode, insert a character after the visual selection. This prevents
  " the previous space from being removed when there are no characters after the current motion
  " (e.g. $). When in line-wise mode, insert a new line below the visual selection. This prevents
  " issues when replacing the last line in the file.
  let insert_command = a:mode ==# 'v' ? "`>a#\<esc> " : "`>o\<esc>"
  execute "normal! " . insert_command

  " Reselect the last visual selection.
  silent execute "normal! gv"

  " Delete the selected text without updating the 0 register.
  silent execute 'normal! "_d'

  " Paste the text from the 0 register.
  silent execute 'normal! P'

  " Remove the added character or line depending on the mode.
  let delete_command = a:mode ==# 'v' ? 'l"_x' : 'j"_dd'
  execute "normal! " . delete_command

  " Move the cursor back to the beginning of the selection.
  silent exec 'normal! `<'
endfunction

" Stamps the current motion in normal mode.
" TODO: Determine if we need to save the registers.
function! MotionStamp(type)

  let saved_register = @@

  " Visually select the last motion (which would be the motion used to call the Stamp script. Then,
  " escape to de-select the motion. This populates the '< and '> marks.
  silent execute "normal! `[v`]\<esc>"

  " Call the visual stamp function with the simulation visual selection.
  call VisualStamp("v")

  let @@ = saved_register
endfunction
