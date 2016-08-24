# vim-nerdtree-syntax-highlight
This adds syntax for nerdtree on most common file extensions. Whether you want to easily see what is going on in a new project, or trying to learn a new framework with a different folder structure, or just trying to make your vim look like it is 2016, this plugin can help you. This is intended to be used with [vim-devicons](https://github.com/ryanoasis/vim-devicons) to add color to icons or entire labels, but will work without it. It is possible to disable highlight, but the syntax will still be available if you want to make something specific with it. The file icons are linked to their labels which are linked to NERDTreeFile, so it will not break anything.

**Warning**: This is sort of a hack and has some limitations.

File syntax will follow this pattern:

| @ | label  | icon |
|---| --- | --- |
|file extensions|nerdtreeFileExtensionLabel_#{extension}|nerdtreeFileExtensionIcon_#{extension}|
|exact match|nerdtreeExactMatchLabel_#{name}|nerdtreeExactMatchIcon_#{name} |
|pattern match |nerdtreePatternMatchLabel_#{pattern_letters}|nerdtreePatternMatchIcon_#{pattern_letters}|

### Screenshots:
![](/screenshots/allfiles.png "All files generated with the generateFiles<span></span>.sh script")
![](/screenshots/railsapp.png "Screenshot of files in a rails app with my current icons setup")

### Installation:
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
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
```
* Highlight full name (not only icons). You need to add this if you don't have [vim-devicons](https://github.com/ryanoasis/vim-devicons) and want highlight.
```vim
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
```
* Highlight folders using exact match
```vim
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
```
* Customizing colors
```vim
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec.rb'] = s:rspec_red " sets the color files ending with _spec.rb

```

* Disable Highlight for specific file extension
```vim
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight
```

Obs: If you have [vim-devicons](https://github.com/ryanoasis/vim-devicons) and you want to customize icons you can customize your icons for each file type.
### generate_files.sh script
There is a script folder called generate_files.sh that will generate all the files supported by this plugin by default for a quick review. These files will be generated on a 'files' subfolder.
