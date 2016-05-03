# vim-nerdtree-syntax-highlight
This adds syntax for nerdtree on most common file extensions. This is intended to be used with [vim-devicons](https://github.com/ryanoasis/vim-devicons) to add color to icons or entire labels, but will work without it.
### Screenshots:
![](/screenshots/allfiles.png "All files generated with the generateFiles<span></span>.sh script")
![](/screenshots/railsapp.png "Screenshot of files in a rails app with my current icons setup")

### Instalation:
##### [neobundle.vim](https://github.com/Shougo/neobundle.vim) :
add this line to your .vimrc or neovim configuration file (usually it is in '~/.config/nvim/init.vim'):
```vim
NeoBundle 'tiagofumo/vim-nerdtree-syntax-highlight'
```
### Dependencies
This plugin is intended to be used with [vim-devicons](https://github.com/ryanoasis/vim-devicons) and to use it you will need to add a new font from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) to your machine so you can see the icons when using vim.
### Configuration
* Disable Highlighting
```vim
let g:NERDTreeDisableFileExtensionHighlight = 1
```
* Highlight full name (not only icons). You need to add this if you don't have [vim-devicons](https://github.com/ryanoasis/vim-devicons) and want highlight.
```vim
let g:NERDTreeFileExtensionHighlightFullName = 1
```
* Customizing colors
```vim
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '00FF00' "sets the color of .css files to green
```
Obs: If you have [vim-devicons](https://github.com/ryanoasis/vim-devicons) and you want to customize Icons you can customize your icons for each file type.
### generateFiles script
There is a script in 'fileColorTest' folder called generateFiles.sh that will generate all the file extension supported by this plugin for a quick review. These files will be generated on a 'files' subfolder.
