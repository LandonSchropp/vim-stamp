" Create the Stamp (S) operator
vnoremap <silent> S :call stamp#VisualStamp(visualmode())<CR>
nnoremap <silent> S :set opfunc=stamp#MotionStamp<CR>g@
nnoremap <silent> SS :call stamp#LineStamp()<CR>
