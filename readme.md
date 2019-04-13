# Vim Stamp

Vim Stamp is a plugin that makes it easy to replace characters with the contents of the delete
register without altering the delete register. This allows you to very quickly replace text without
the need for macros.

## Installation

Vim Stamp can be installed using your favorite Vim plugin manager. I would recommend using
[vim-plug](https://github.com/junegunn/vim-plug).

``` vim
Plug 'landonschropp/vim-stamp'
```

## Local Development

This repo comes with a few scripts to make local development much easier:

* [`bin/run`](bin/run): Execute arbitrary commands inside of a Neovim instance that only has Vader
  and the stamp plugin loaded.
* [`bin/test`](bin/test): Run the test suite.
* [`bin/example`](bin/run): Calls `bin/run` and loads a buffer with sample data for easy debugging.
