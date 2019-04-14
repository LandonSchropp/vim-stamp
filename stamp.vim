" Create Stamp (S) operator
vnoremap <silent> S :call VisualStamp(visualmode())<CR>
nnoremap <silent> S :set opfunc=MotionStamp<CR>g@
nnoremap <silent> SS :call LineStamp()<CR>

" Stamps a visual selection in the given mode.
function! VisualStamp(mode) range
  if a:mode ==# "V"
    call VisualLineStamp()
  elseif a:mode ==# "v"
    call VisualCharacterStamp()
  endif
endfunction

" Stamps a character-wise visual selection.
function! VisualCharacterStamp() range

  " Insert a character after the visual selection. This prevents the previous space from being
  " removed when there are no characters after the current motion (e.g. $).
  silent execute "normal! `>a#\<esc>"

  " Reselect the last visual selection.
  silent execute "normal! gv"

  " Delete the selected text without updating the unnamed register.
  silent execute 'normal! "_d'

  " If the text in the unnamed register ends with a newline, remove it.
  if @@[-1:] ==# "\n"
    let @@ = @@[0:-2]
  endif

  " Paste the text from the unnamed register.
  silent execute 'normal! gP'

  " Remove the added character.
  silent execute 'normal! "_x'
endfunction

" Stamps the current selection in visual mode.
function! VisualLineStamp() range

  " Insert a new line below the visual selection. This prevents issues when replacing the last line
  " in the file.
  silent execute "normal! `>o\<esc>"

  " Reselect the last visual selection.
  silent execute "normal! gv"

  " Delete the selected text without updating the unnamed register.
  silent execute 'normal! "_d'

  " If the text in the unnamed register doesn't end in a newline, add one.
  if @@[-1:] !=# "\n"
    let @@ = @@ . "\n"
  endif

  " Paste the text from the unnamed register. Use `gP` so the cursor is left on the line after the
  " paste.
  silent execute 'normal! gP'

  " Remove the added line.
  silent execute 'normal! "_dd'
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
