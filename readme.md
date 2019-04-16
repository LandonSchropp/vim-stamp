# Vim Stamp

Stamp is a [NeoVim](https://neovim.io/) and [Vim](https://www.vim.org/) plugin that makes it easy to
replace text with the contents of the last command. This allows you to very quickly replace text in
a repeatable way without the need for macros.

## Demo

This is easiest to explain with a demo. Let's take this line of text as an example:

```
Hello Hola Bonjour Olà Hallo
```

With your cursor on Hello, run `yiw` to copy the first word.

```
[H]ello Hola Bonjour Olà Hallo
```

Next, his `w` to move to `Hola` and run `Siw` (stamp inner word).

```
Hello [H]ello Bonjour Olà Hallo
```

Tuh duh! You've just stamped a word. The contents of your unnamed register (in this case when you
yanked the first word) have now replaced the second word. You can use Stamp with any command that
populates the unnamed register, such as `d`, `dd`, `y`, `yy` and `x`.

If you have [repeat.vim](https://github.com/tpope/vim-repeat) installed, you can repeat a stamp with
the `.` key. Try it by switching to the next word and then stamping again with `w.`.

```
Hello Hello [H]ello Olà Hallo
```

The great thing about Stamp is it works with any motion. That means you have maximum flexibility
when stamping. Some of the more useful motions include stamping inside strings (`Si"`), stamping
blocks (`Sib`), stamping paragraphs (`Sip`) and stamping until the end of the line (`S$`).

Stamp supports the following modes:

* Normal mode motions (`S<motion>`)
* Visual line selections (`V<motion>S`)
* Visual character selections (`v<motion>S`)
* Lines (`SS`)

## Installation

Stamp can be installed using your favorite Vim plugin manager. I recommend using
[vim-plug](https://github.com/junegunn/vim-plug).

``` vim
Plug 'LandonSchropp/vim-stamp'
```

If you'd like Stamp to work with the repeat key (`.`), you need to install the
[repeat.vim](https://github.com/tpope/vim-repeat) plugin as well.

## Development

If you'd like to poke around in this repo, it comes with a few scripts to make local development
much easier:

* [`bin/run`](bin/run): Execute arbitrary commands inside of a Neovim instance that only has Vader
  and Stamp loaded.
* [`bin/test`](bin/test): Run the Vader test suite.
* [`bin/example`](bin/run): Calls `bin/run` and loads a buffer with some sample data for easy,
  on-the-fly testing.
