" This is a simplified Vim configuration that's used to test the stamp plugin. This was taken from
" the Vader instructions on setting up an isolated testing environment.
" https://github.com/junegunn/vader.vim#setting-up-isolated-testing-environment

" Ensure the text is readable on my terminal's color scheme.
set background=light

" Override the runtime path and only load Vader.
set runtimepath=~/.vim/bundle/vader.vim

" Include the stamp plugin.
exec 'source' expand('%:p:h') . '/stamp.vim'
