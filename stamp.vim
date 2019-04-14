" Create Stamp (S) operator
vnoremap <silent> S :call VisualStamp(visualmode())<CR>
nnoremap <silent> S :set opfunc=MotionStamp<CR>g@
nnoremap <silent> SS :call LineStamp()<CR>

" If the mode is line-wise visual and the `@` register does not end in a newline, this function adds
" one. If the model is character-wise visual and the `@` register ends in a newline, this function
" removes it.
function! s:NormalizedUnnamedRegister(mode)
  if a:mode ==# "V"
    if @@[-1:] !=# "\n"
      let @@ = @@ . "\n"
    endif
  else
    if @@[-1:] ==# "\n"
      let @@ = @@[0:-2]
    endif
  endif
endfunction

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

  " When inserting in line-wise mode, it's possible the text in the unnamed register was not yanked
  " in a block mode. In order to avoid issues, it's best to add a newline to it if one does not
  " already exist.
  call s:NormalizedUnnamedRegister(a:mode)

  " Paste the text from the 0 register. Use `gP` so the cursor is left on the same character.
  silent execute 'normal! gP'

  " Remove the added character or line depending on the mode.
  let delete_command = a:mode ==# 'v' ? '"_x' : '"_dd'
  execute "normal! " . delete_command
endfunction

" Stamps the current motion in normal mode.
" TODO: Determine if we need to save the registers.
function! MotionStamp(type)

  let unnamed_register = @@

  " Visually select the last motion (which would be the motion used to call the Stamp script. Then,
  " escape to de-select the motion. This populates the '< and '> marks.
  silent execute "normal! `[v`]\<esc>"

  " Call the visual stamp function with the simulation visual selection.
  call VisualStamp("v")

  let @@ = unnamed_register
endfunction

" Stamps the current line.
function! LineStamp()

  " Visually select the current line.
  silent execute "normal! V"

  " Call the visual stamp function with the simulation visual selection.
  call VisualStamp("V")
endfunction
