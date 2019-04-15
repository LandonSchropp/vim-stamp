# Vim Stamp

Vim Stamp is a plugin that makes it easy to repeatedly replace text without affecting your
`0` register. This allows you to very quickly replace text in a repeatable way without the need for
macros.

Vim Stamp works with normal mode motions (`S<motion>`), visual line selections (`V<motion>S`),
visual character selections (`v<motion>S`) and entire lines (`SS`). Vim Stamp also works with the
repeat key (`.`) if you have the excellent [repeat.vim]() plugin installed (and you should).

## Installation

Vim Stamp can be installed using your favorite Vim plugin manager. I recommend using
[vim-plug](https://github.com/junegunn/vim-plug).

``` vim
Plug 'LandonSchropp/vim-stamp'
```

## Development

If you'd like to poke around in this repo, it comes with a few scripts to make local development
much easier:

* [`bin/run`](bin/run): Execute arbitrary commands inside of a Neovim instance that only has Vader
  and Vim Stamp loaded.
* [`bin/test`](bin/test): Run the Vader test suite.
* [`bin/example`](bin/run): Calls `bin/run` and loads a buffer with some sample data for easy,
  on-the-fly testing.
