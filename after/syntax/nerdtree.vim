if has("gui_running") || &t_Co == 88 || &t_Co == 256
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
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . s:rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . s:rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun
endif

"the original values would be 24 bit color but apparently that is not possible
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
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"

let s:file_extension_colors = {
	\	'styl'     : s:green,
	\	'scss'     : s:pink,
	\	'htm'      : s:darkOrange,
	\	'html'     : s:darkOrange,
	\	'erb'      : s:red,
	\	'slim'     : s:orange,
	\	'ejs'      : s:yellow,
	\	'css'      : s:blue,
	\	'less'     : s:darkBlue,
	\	'md'       : s:yellow,
	\	'markdown' : s:yellow,
	\	'json'     : s:beige,
	\	'js'       : s:beige,
	\	'jsx'      : s:blue,
	\	'rb'       : s:red,
	\	'php'      : s:purple,
	\	'py'       : s:yellow,
	\	'pyc'      : s:yellow,
	\	'pyo'      : s:yellow,
	\	'pyd'      : s:yellow,
	\	'coffee'   : s:brown,
	\	'mustache' : s:orange,
	\	'hbs'      : s:orange,
	\	'conf'     : s:white,
	\	'ini'      : s:white,
	\	'yml'      : s:white,
	\	'bat'      : s:white,
	\	'jpg'      : s:aqua,
	\	'jpeg'     : s:aqua,
	\	'bmp'      : s:aqua,
	\	'png'      : s:aqua,
	\	'gif'      : s:aqua,
	\	'ico'      : s:aqua,
	\	'twig'     : s:green,
	\	'cpp'      : s:blue,
	\	'c++'      : s:blue,
	\	'cxx'      : s:blue,
	\	'cc'       : s:blue,
	\	'cp'       : s:blue,
	\	'c'        : s:blue,
	\	'hs'       : s:beige,
	\	'lhs'      : s:beige,
	\	'lua'      : s:purple,
	\	'java'     : s:purple,
	\	'sh'       : s:lightPurple,
	\	'fish'     : s:green,
	\	'ml'       : s:yellow,
	\	'mli'      : s:yellow,
	\	'diff'     : s:white,
	\	'db'       : s:blue,
	\	'sql'      : s:darkBlue,
	\	'dump'     : s:blue,
	\	'clj'      : s:green,
	\	'cljc'     : s:green,
	\	'cljs'     : s:green,
	\	'edn'      : s:green,
	\	'scala'    : s:red,
	\	'go'       : s:beige,
	\	'dart'     : s:blue,
	\	'xul'      : s:darkOrange,
	\	'sln'      : s:purple,
	\	'suo'      : s:purple,
	\	'pl'       : s:blue,
	\	'pm'       : s:blue,
	\	't'        : s:blue,
	\	'rss'      : s:darkOrange,
	\	'f#'       : s:darkBlue,
	\	'fsscript' : s:blue,
	\	'fsx'      : s:blue,
	\	'fs'       : s:blue,
	\	'fsi'      : s:blue,
	\	'rs'       : s:darkOrange,
	\	'rlib'     : s:darkOrange,
	\	'd'        : s:red,
	\	'erl'      : s:lightPurple,
	\	'hrl'      : s:pink,
	\	'vim'      : s:green,
	\	'ai'       : s:darkOrange,
	\	'psd'      : s:darkBlue,
	\	'psb'      : s:darkBlue,
	\	'ts'       : s:blue,
	\	'jl'       : s:purple
\}


if !exists('g:NERDTreeExtensionHighlightColor')
  let g:NERDTreeExtensionHighlightColor = {}
endif

for [key, val] in items(s:file_extension_colors)
  if !has_key(g:NERDTreeExtensionHighlightColor , key)
    let g:NERDTreeExtensionHighlightColor[key] = val
  endif
endfor


for [key, val] in items(g:NERDTreeExtensionHighlightColor)
  exec 'syn match nerdtreeFileExtensionLabel_'.key.' ".*\.'.key.'$" containedin=NERDTreeFile'
  exec 'hi def link nerdtreeFileExtensionLabel_'.key.' NERDTreeFile'

  if exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["'.key.'"]')
    let icon = g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[key]
    exec 'syn match nerdtreeFileExtensionIcon_'.key.' #'.icon.'# containedin=nerdtreeFileExtensionLabel_'.key
    exec 'hi def link nerdtreeFileExtensionIcon_'.key.' nerdtreeFileExtensionLabel_'.key

    if !exists('g:NERDTreeDisableFileExtensionHighlight') && val != ''
      "exec 'highlight nerdtreeFileExtensionIcon_'.key.' ctermbg=none ctermfg=#'.val.' guifg=#'.val
	  if exists('g:NERDTreeFileExtensionHighlightFullName')
	    call s:X('nerdtreeFileExtensionLabel_'.key, val, '', '')
      else
	    call s:X('nerdtreeFileExtensionIcon_'.key, val, '', '')
	  endif
    endif
  endif
endfor

