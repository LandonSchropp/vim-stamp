" Stamps a visual selection in the given mode.
function! stamp#VisualStamp(mode) range
  if a:mode ==# "V"
    call stamp#VisualLineStamp()
  elseif a:mode ==# "v"
    call stamp#VisualCharacterStamp()
  endif
endfunction

" Stamps a character-wise visual selection.
function! stamp#VisualCharacterStamp() range

  " Store the line, column and column width of the end of the selection before we manipulate the
  " text.
  let [ s:line, s:column ] = getpos("'>")[1:2]
  let s:column_width = strwidth(getline(s:line))

  " Insert a character after the visual selection. This prevents the previous space from being
  " removed when there are no characters after the current motion (e.g. $).
  silent execute "normal! `>a#\<esc>"

  " Reselect the last visual selection.
  silent execute "normal! gv"

  " If the value of the `selection` variable is set to `inclusive` or `exclusive`, it's possible for
  " the selection to extend beyond the end of the line. If that happens, the extra character logic
  " will break. At first, I tried to solve this by setting the local `selection` value to `old`.
  " However, that doesn't work because `gv` will select the extra character, even after this setting
  " is enabled. In order to avoid this problem, the solution is to detect if the selection extends
  " beyond the line length, and if so to move it to the left one character.
  if s:column > s:column_width
    silent execute 'normal! ' . (s:column - s:column_width) . 'h'
  endif

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
function! stamp#VisualLineStamp() range

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
function! stamp#MotionStamp(type)

  let unnamed_register = @@

  " Visually select the last motion (which would be the motion used to call the Stamp script. Then,
  " escape to de-select the motion. This populates the '< and '> marks.
  silent execute "normal! `[v`]\<esc>"

  " Call the visual stamp function with the simulation visual selection.
  call stamp#VisualStamp("v")

  let @@ = unnamed_register
endfunction

" Stamps the current line.
function! stamp#LineStamp()

  " Visually select the current line.
  silent execute "normal! V\<esc>"

  " Call the visual stamp function with the simulation visual selection.
  call stamp#VisualStamp("V")
endfunction
