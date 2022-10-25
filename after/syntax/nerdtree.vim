"I borrowed this crazy code from vim-tomorrow-theme colorschemes

" Returns an approximate grey index for the given grey level
fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual grey level represented by the grey index
fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" Returns the palette index for the given grey index
fun! s:grey_colour(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" Returns an approximate colour index for the given colour level
fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual colour level for the given colour index
fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" Returns the palette index for the given R/G/B colour indices
fun! s:rgb_colour(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" Returns the palette index to approximate the given R/G/B colour levels
fun! s:colour(r, g, b)
  " Get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " Get the closest colour
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " There are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " Use the grey
      return s:grey_colour(l:gx)
    else
      " Use the colour
      return s:rgb_colour(l:x, l:y, l:z)
    endif
  else
    " Only one possibility
    return s:rgb_colour(l:x, l:y, l:z)
  endif
endfun

" Returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

  return s:colour(l:r, l:g, l:b)
endfun

" Sets the highlighting for the given group
fun! s:X(group, fg, bg, attr)
  if a:fg != ""
    exec "silent hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . s:rgb(a:fg)
  endif
  if a:bg != ""
    exec "silent hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . s:rgb(a:bg)
  endif
  if a:attr != ""
    exec "silent hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

"the original values would be 24 bit color but apparently that is not possible
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:juliaPurple = "9558B2"
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
let s:vuejs = '42B883'

let s:file_extension_colors = {
  \ 'styl'     : s:green,
  \ 'sass'     : s:pink,
  \ 'scss'     : s:pink,
  \ 'htm'      : s:darkOrange,
  \ 'html'     : s:darkOrange,
  \ 'erb'      : s:red,
  \ 'slim'     : s:orange,
  \ 'ejs'      : s:yellow,
  \ 'css'      : s:blue,
  \ 'less'     : s:darkBlue,
  \ 'md'       : s:yellow,
  \ 'mdx'      : s:yellow,
  \ 'markdown' : s:yellow,
  \ 'rmd'      : s:yellow,
  \ 'json'     : s:beige,
  \ 'js'       : s:beige,
  \ 'mjs'      : s:beige,
  \ 'jsx'      : s:blue,
  \ 'rb'       : s:red,
  \ 'php'      : s:purple,
  \ 'py'       : s:yellow,
  \ 'pyc'      : s:yellow,
  \ 'pyo'      : s:yellow,
  \ 'pyd'      : s:yellow,
  \ 'coffee'   : s:brown,
  \ 'mustache' : s:orange,
  \ 'hbs'      : s:orange,
  \ 'conf'     : s:white,
  \ 'ini'      : s:white,
  \ 'yml'      : s:white,
  \ 'yaml'     : s:white,
  \ 'toml'     : s:white,
  \ 'bat'      : s:white,
  \ 'jpg'      : s:aqua,
  \ 'jpeg'     : s:aqua,
  \ 'bmp'      : s:aqua,
  \ 'png'      : s:aqua,
  \ 'webp'     : s:aqua,
  \ 'gif'      : s:aqua,
  \ 'ico'      : s:aqua,
  \ 'twig'     : s:green,
  \ 'cpp'      : s:blue,
  \ 'c++'      : s:blue,
  \ 'cxx'      : s:blue,
  \ 'cc'       : s:blue,
  \ 'cp'       : s:blue,
  \ 'c'        : s:blue,
  \ 'cs'       : s:blue,
  \ 'h'        : s:blue,
  \ 'hh'       : s:blue,
  \ 'hpp'      : s:blue,
  \ 'hxx'      : s:blue,
  \ 'hs'       : s:beige,
  \ 'lhs'      : s:beige,
  \ 'lua'      : s:purple,
  \ 'java'     : s:purple,
  \ 'sh'       : s:lightPurple,
  \ 'fish'     : s:green,
  \ 'bash'     : s:lightPurple,
  \ 'zsh'      : s:white,
  \ 'ksh'      : s:white,
  \ 'csh'      : s:white,
  \ 'awk'      : s:white,
  \ 'ps1'      : s:blue,
  \ 'ml'       : s:yellow,
  \ 'mli'      : s:yellow,
  \ 'diff'     : s:white,
  \ 'db'       : s:blue,
  \ 'sql'      : s:darkBlue,
  \ 'dump'     : s:blue,
  \ 'clj'      : s:green,
  \ 'cljc'     : s:green,
  \ 'cljs'     : s:green,
  \ 'edn'      : s:green,
  \ 'scala'    : s:red,
  \ 'go'       : s:beige,
  \ 'dart'     : s:blue,
  \ 'xul'      : s:darkOrange,
  \ 'sln'      : s:purple,
  \ 'suo'      : s:purple,
  \ 'pl'       : s:blue,
  \ 'pm'       : s:blue,
  \ 't'        : s:blue,
  \ 'rss'      : s:darkOrange,
  \ 'f#'       : s:darkBlue,
  \ 'fsscript' : s:blue,
  \ 'fsx'      : s:blue,
  \ 'fs'       : s:blue,
  \ 'fsi'      : s:blue,
  \ 'rs'       : s:darkOrange,
  \ 'rlib'     : s:darkOrange,
  \ 'd'        : s:red,
  \ 'erl'      : s:lightPurple,
  \ 'hrl'      : s:pink,
  \ 'ex'       : s:purple,
  \ 'exs'      : s:purple,
  \ 'eex'      : s:purple,
  \ 'leex'     : s:white,
  \ 'vim'      : s:green,
  \ 'ai'       : s:darkOrange,
  \ 'psd'      : s:darkBlue,
  \ 'psb'      : s:darkBlue,
  \ 'ts'       : s:blue,
  \ 'tsx'      : s:blue,
  \ 'jl'       : s:juliaPurple,
  \ 'pp'       : s:white,
  \ 'vue'      : s:vuejs,
  \ 'elm'      : s:white,
  \ 'swift'    : s:orange,
  \ 'xcplayground' : s:orange
\}

let s:file_node_exact_matches = {
  \ 'gruntfile.coffee'                 : s:yellow,
  \ 'gruntfile.js'                     : s:yellow,
  \ 'gruntfile.ls'                     : s:yellow,
  \ 'gulpfile.coffee'                  : s:pink,
  \ 'gulpfile.js'                      : s:pink,
  \ 'gulpfile.ls'                      : s:pink,
  \ 'mix.lock'                         : s:white,
  \ 'dropbox'                          : s:blue,
  \ '.ds_store'                        : s:white,
  \ '.gitconfig'                       : s:white,
  \ '.gitignore'                       : s:white,
  \ '.gitlab-ci.yml'                   : s:orange,
  \ '.bashrc'                          : s:white,
  \ '.zshrc'                           : s:white,
  \ '.vimrc'                           : s:green,
  \ '.gvimrc'                          : s:green,
  \ '_vimrc'                           : s:green,
  \ '_gvimrc'                          : s:green,
  \ '.bashprofile'                     : s:white,
  \ 'favicon.ico'                      : s:yellow,
  \ 'license'                          : s:white,
  \ 'node_modules'                     : s:green,
  \ 'react.jsx'                        : s:blue,
  \ 'typescript.jsx'                   : s:blue,
  \ 'typescript.tsx'                   : s:blue,
  \ 'procfile'                         : s:purple,
  \ 'dockerfile'                       : s:blue,
  \ 'docker-compose.yml'               : s:blue,
  \ 'makefile'                         : s:white,
  \ 'cmakelists.txt'                   : s:white
\}

let s:file_node_pattern_matches = {
  \ '.*jquery.*\.js$'       : s:blue,
  \ '.*angular.*\.js$'      : s:red,
  \ '.*backbone.*\.js$'     : s:darkBlue,
  \ '.*require.*\.js$'      : s:blue,
  \ '.*materialize.*\.js$'  : s:salmon,
  \ '.*materialize.*\.css$' : s:salmon,
  \ '.*mootools.*\.js$'     : s:white,
  \ '.*vimrc.*'             : s:green,
  \ 'Vagrantfile$'          : s:blue
\}

let s:enabled_extensions = [
  \ 'bmp',
  \ 'c',
  \ 'coffee',
  \ 'cpp',
  \ 'cs',
  \ 'css',
  \ 'erb',
  \ 'go',
  \ 'hs',
  \ 'html',
  \ 'java',
  \ 'jpg',
  \ 'js',
  \ 'json',
  \ 'jsx',
  \ 'less',
  \ 'lua',
  \ 'markdown',
  \ 'md',
  \ 'php',
  \ 'png',
  \ 'pl',
  \ 'py',
  \ 'rb',
  \ 'rs',
  \ 'scala',
  \ 'scss',
  \ 'sh',
  \ 'sql',
  \ 'vim',
\]

if !exists('g:NERDTreeSyntaxEnabledExtensions')
  let g:NERDTreeSyntaxEnabledExtensions = []
endif

if !exists('g:NERDTreeSyntaxEnabledExactMatches')
  let g:NERDTreeSyntaxEnabledExactMatches = []
endif

if exists('g:NERDTreeLimitedSyntax') && !exists('g:NERDTreeSyntaxDisableDefaultExtensions')
  for extension in s:enabled_extensions
    call add(g:NERDTreeSyntaxEnabledExtensions, extension)
  endfor
endif

let s:characters = '[ a-zA-Z0-9_\#\-\+\*\%\!\~\(\)\{\}\&\.\$\@]'
" substitute will 'eliminate' single backlashes on the string
let s:chars_double_lashes = substitute(s:characters, '\\', '\\\\', 'g')

" Extension colors
if !exists('g:NERDTreeExtensionHighlightColor')
  let g:NERDTreeExtensionHighlightColor = {}
endif

for [key, val] in items(s:file_extension_colors)
  if (!(exists('g:NERDTreeLimitedSyntax') ||
        \ exists('g:NERDTreeSyntaxDisableDefaultExtensions')) ||
        \ index(g:NERDTreeSyntaxEnabledExtensions, key) >= 0) &&
        \ !has_key(g:NERDTreeExtensionHighlightColor, key)
    let g:NERDTreeExtensionHighlightColor[key] = val
  endif
endfor

for [key, val] in items(g:NERDTreeExtensionHighlightColor)
  let label_identifier = 'nerdtreeFileExtensionLabel_'.key
  let icon_identifier = 'nerdtreeFileExtensionIcon_'.key
  let regexp = '\v'.s:characters.'+\.'.substitute(key, '\W', '\\\0', 'g')

  exec 'silent syn match '.label_identifier.' "'.regexp.'$" containedin=NERDTreeFile'
  exec 'silent syn match '.label_identifier.' "'.regexp.'\W*\*$" containedin=NERDTreeExecFile'
  exec 'hi def link '.label_identifier.' NERDTreeFile'

  if exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["'.key.'"]')
    let icon = g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[key]
    exec 'silent syn match '.icon_identifier.' "\zs['.icon.']\ze.\+\.'.key.'$" containedin=NERDTreeFlags'
    exec 'silent syn match '.icon_identifier.' "\zs['.icon.']\ze.\+\.'.key.'\W*\*$" containedin=NERDTreeFlags'
    exec 'hi def link '.icon_identifier.' '.label_identifier
  endif

  if !exists('g:NERDTreeDisableFileExtensionHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreeFileExtensionHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
  endif
endfor

"Exact Matches
if !exists('g:NERDTreeExactMatchHighlightColor')
  let g:NERDTreeExactMatchHighlightColor = {}
endif

for [key, val] in items(s:file_node_exact_matches)
  if (!exists('g:NERDTreeSyntaxDisableDefaultExactMatches') ||
        \ index(g:NERDTreeSyntaxEnabledExactMatches, key) >= 0) &&
        \ !has_key(g:NERDTreeExactMatchHighlightColor, key)
    let g:NERDTreeExactMatchHighlightColor[key] = val
  endif
endfor

for [key, val] in items(g:NERDTreeExactMatchHighlightColor)
  let label_identifier = 'nerdtreeExactMatchLabel_'.key
  let icon_identifier = 'nerdtreeExactMatchIcon_'.key
  let folder_identifier = 'nerdtreeExactMatchFolder_'.key
  let folder_icon_identifier = 'nerdtreeExactMatchFolderIcon_'.key
  exec 'silent syn match '.label_identifier.' "\c'.key.'$" containedin=NERDTreeFile'
  exec 'silent syn match '.label_identifier.' "\c'.key.'\W*\*$" containedin=NERDTreeExecFile'
  exec 'hi def link '.label_identifier.' NERDTreeFile'
  exec 'silent syn match '.folder_identifier.' "\v\c<'.key.'\ze\/" containedin=NERDTreeDir'
  exec 'hi def link '.folder_identifier.' NERDTreeFlags'
  if exists('g:WebDevIconsUnicodeDecorateFileNodesExactSymbols["'.key.'"]')
    let icon = g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[key]
    exec 'silent syn match '.icon_identifier.' "\c['.icon.']\ze.*'.key.'$" containedin=NERDTreeFlags'
    exec 'silent syn match '.icon_identifier.' "\c['.icon.']\ze.*'.key.'\W*\*$" containedin=NERDTreeFlags'
    exec 'hi def link '.icon_identifier.' '.label_identifier
    exec 'silent syn match '.folder_icon_identifier.' "\c['.icon.']\ze.*'.key.'\/" containedin=NERDTreeFlags'
    exec 'hi def link '.folder_icon_identifier.' '.folder_identifier
  endif

  if !exists('g:NERDTreeDisableExactMatchHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreeExactMatchHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
    if exists('g:NERDTreeHighlightFolders')
      call s:X(folder_icon_identifier, val, '', '')
      if exists('g:NERDTreeHighlightFoldersFullName')
        call s:X(folder_identifier, val, '', '')
      endif
    endif
  endif
endfor

"Pattern Matches
if !exists('g:NERDTreePatternMatchHighlightColor')
  let g:NERDTreePatternMatchHighlightColor = {}
endif

for [key, val] in items(s:file_node_pattern_matches)
  if !exists('g:NERDTreeSyntaxDisableDefaultPatternMatches') &&
        \ !has_key(g:NERDTreePatternMatchHighlightColor, key)
    let g:NERDTreePatternMatchHighlightColor[key] = val
  endif
endfor

for [key, val] in items(g:NERDTreePatternMatchHighlightColor)
  let suffix = substitute(key, '\W', '', 'g')
  let label_identifier = 'nerdtreePatternMatchLabel_'.suffix
  let icon_identifier = 'nerdtreePatternMatchIcon_'.suffix
  let sub_regexp = substitute(key, '\v\\@<!\.', s:chars_double_lashes, 'g')
  let exec_sub_regexp = substitute(sub_regexp, '\$$', '\\W\*\\\*\$', '')

  exec 'syn match '.label_identifier.' "\v\c'.sub_regexp.'" containedin=NERDTreeFile'
  exec 'syn match '.label_identifier.' "\v\c'.exec_sub_regexp.'" containedin=NERDTreeExecFile'
  exec 'hi def link '.label_identifier.' NERDTreeFile'

  if exists("g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['".key."']")
    let icon = g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols[key]
    exec 'syn match '.icon_identifier.' "\v\c\zs['.icon.']\ze.*'.sub_regexp.'" containedin=NERDTreeFlags'
    exec 'syn match '.icon_identifier.' "\v\c\zs['.icon.']\ze.*'.exec_sub_regexp.'" containedin=NERDTreeFlags'
    exec 'hi def link '.icon_identifier.' '.label_identifier
  endif

  if !exists('g:NERDTreeDisablePatternMatchHighlight') && val != ''
    call s:X(icon_identifier, val, '', '')
    if exists('g:NERDTreePatternMatchHighlightFullName')
      call s:X(label_identifier, val, '', '')
    endif
  endif
endfor

if exists("g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol")
  let icon_closed = g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol
  let icon_open = g:DevIconsDefaultFolderOpenSymbol
  let identifier = 'WebDevIconsDefaultFolderSymbol'
  let open_identifier = 'WebDevIconsDefaultOpenFolderSymbol'
  exec 'silent syn match '.identifier.' "\c['.icon_closed.']\ze.*/" containedin=NERDTreeFlags'
  exec 'silent syn match '.open_identifier.' "\c['.icon_open.']\ze.*/" containedin=NERDTreeFlags'
  if !exists('g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir')
    exec 'hi def link '.identifier.' NERDTreeDir'
    exec 'hi def link '.open_identifier.' NERDTreeDir'
  else
    " exec 'hi def link '.identifier.' NERDTreeFlags'
    let NERDTreeFlagsTrans = synIDattr(synIDtrans(hlID('NERDTreeFlags')), 'name')
    exec 'hi def link '.identifier.' '.NERDTreeFlagsTrans
    exec 'hi def link '.open_identifier.' '.NERDTreeFlagsTrans
  endif
  if exists('g:WebDevIconsDefaultFolderSymbolColor')
    call s:X(identifier, g:WebDevIconsDefaultFolderSymbolColor, '', '')
  endif
  if exists('g:WebDevIconsDefaultOpenFolderSymbolColor')
    call s:X(open_identifier, g:WebDevIconsDefaultOpenFolderSymbolColor, '', '')
  endif
endif

if exists("g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol")
  let icon = g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol
  let identifier = 'WebDevIconsDefaultFileSymbol '
  exec 'silent syn match '.identifier.' "\v\c\zs['.icon.']\ze.*" containedin=NERDTreeFlags'
  if !exists('g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile')
    exec 'hi def link '.identifier.' NERDTreeFile'
    exec 'hi! def link NERDTreeFlags NERDTreeFile'
  else
    exec 'hi def link '.identifier.' NERDTreeFlags'
  endif
  if exists('g:WebDevIconsDefaultFileSymbolColor')
    call s:X(identifier, g:WebDevIconsDefaultFileSymbolColor, '', '')
  endif
endif
