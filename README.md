# NeoVim Scala Config

## System requirements

I'm working on a Mac, here is a list of things I know I needed to install, all of which I did via homebrew:

- NeoVim
- Vundle (I've heard `vim-plug` is more modern, but Vundle is working fine for me so far)
- OneDark theme files? Check the git repo for more info.
- Scala
- SBT
- Scalafmt
- NPM
- Node
- Yarn
- Coursier (might have been a direct download?)
- OpenJDK - I'm using 11, metals supports 8 or 11 at the time of writing.

## Reference links

[Scala Metals for Vim](https://scalameta.org/metals/docs/editors/vim.html#lsp-commands-key-mapping)

## Setup (the bits I can remember)

Clone this repo into `~/.config/nvim/` so that `init.vim` is at `~/.config/nvim/init.vim` as is `coc-settings.json`.

In your terminal, open `nvim` - I often open `nvim ~/.config/nvim/init.vim` only because if this doesn't work I'm probably going to be tweaking the setting file again!

Type: `:PluginInstall` then `:CocInstall` - think you only have to do that last one once.

Restart NeoVim.

## Notes

Look at the plugins in the config file. I've added a bunch of things for IDE-like workflow tools but it's left to the reader to check the docs for each one. FZF and Nerdtree are important, go read up.

The Scala metals keyboard shortcuts are largely in the config file or in the link above... because it gives you the config file...

I'm using the automatic update / install version of Metals via CoC (conqueror of completetion or something), other options on the link.

I had a problem where my scala project was in a sub folder of the git repo and vim/coc/metals was confused because it assumes the workspace  starts at the git repo. I'm hoping I've fixed this in the `coc-settings.json` file, but a workaround is to drop a folder called `.vim` next to your `build.sbt` file and then it does the right thing.
