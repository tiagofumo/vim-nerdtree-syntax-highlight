# vim-nerdtree-syntax-highlight
This adds syntax for nerdtree on most common file extensions. Whether you want to easily see what is going on in a new project, trying to learn a new framework with a different folder structure, or just trying to make your NERDTree look better, this plugin can help you. This is intended to be used with [vim-devicons](https://github.com/ryanoasis/vim-devicons) to add color to icons or entire labels, but will work without it. It is possible to disable highlight, but the syntax will still be available if you want to make something specific with it. The file icons are linked to their labels which are linked to NERDTreeFile, so it will not break anything.

File syntax will follow this pattern:

| @ | label  | icon |
|---| --- | --- |
|file extensions|nerdtreeFileExtensionLabel_#{extension}|nerdtreeFileExtensionIcon_#{extension}|
|exact match|nerdtreeExactMatchLabel_#{name}|nerdtreeExactMatchIcon_#{name} |
|pattern match |nerdtreePatternMatchLabel_#{pattern_letters}|nerdtreePatternMatchIcon_#{pattern_letters}|
|unmatched folders|WebDevIconsDefaultFolderSymbol|set with config from [vim-devicons](https://github.com/ryanoasis/vim-devicons)
|unmatched files|WebDevIconsDefaultFileSymbol|set with config from [vim-devicons](https://github.com/ryanoasis/vim-devicons)

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
* Disable unmatched folder and file icons having the same color as their labels (normally green and white), if set by this plugin (it could have been set by some other plugin that you are using).
```vim
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
```
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
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule
```

* Disable Highlight for specific file extension
```vim
" If you have vim-devicons you can customize your icons for each file type.
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight
```
* Disable uncommon file extensions highlighting (this is a good idea if you are experiencing lag when scrolling. Find more about lag on next session.)
```vim
let g:NERDTreeLimitedSyntax = 1
```
* Disable all default file highlighting (you can use this to easily customize all the highlighting rules)
```vim
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
```
* Customize which file extensions are enabled (you only need this if you set `g:NERDTreeLimitedSyntax`, `g:NERDTreeSyntaxDisableDefaultExtensions` or `g:NERDTreeSyntaxDisableDefaultExactMatches`)
```vim
" set g:NERDTreeExtensionHighlightColor if you want a custom color instead of the default one
let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to .hbs and .lhs files with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['dropbox', 'node_modules', 'favicon.ico'] " enable highlight for dropbox and node_modules folders, and favicon.ico files with default colors
```
### Mitigating lag issues
Some users are reporting they feel some lag when using this plugin. There are ways to mitigate this lag. One way is to disable most of the the default highlight exntensions. The code is going to color over than 80 extensions by default, even if you are not using most of them. One easy way to do this is using the limited syntax mode:
```vim
let g:NERDTreeLimitedSyntax = 1
```
This configuration will limit the extensions used to these:
```
.bmp, .c, .coffee, .cpp, .cs, .css, .erb, .go, .hs, .html, .java, .jpg, .js, .json, .jsx, .less, .lua, .markdown, .md, .php, .png, .pl, .py, .rb, .rs, .scala, .scss, .sh, .sql, .vim
```
If this doens't solve your lag, or doesn't include the extensions you normaly use, you can choose the extensions you want to enable. For example, if you work with C, php, ruby and javascript, you could add something like this to your `.vimrc` instead:
```vim
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'cpp', 'php', 'rb', 'js', 'css', 'html'] " enabled extensions with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['node_modules', 'favicon.ico'] " enabled exact matches with default colors
```
A user reported that disabling `Cursorline` highlight from NERDTree fixed the issue. You can do this by adding this configuration to your `.vimrc`:
```vim
let g:NERDTreeHighlightCursorline = 0
```
There is an [issue](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight/issues/6) about this lag problem. If you find any solutions please comment there, so other people can see it.
### Current limitation on finding and solving bugs on different setups
There are many different setups one can have while using vim (neovim, gvim, different terminals, with tmux, different operating systems, etc) which makes it harder to debug setup specific issues.
### generate_files.sh script
There is a script called generate_files.sh that will generate all the files supported by this plugin by default for a quick review. These files will be generated on a 'files' subfolder.
