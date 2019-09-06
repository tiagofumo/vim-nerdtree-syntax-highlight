extensions=(
  \ 'styl'
  \ 'scss'
  \ 'htm'
  \ 'html'
  \ 'erb'
  \ 'slim'
  \ 'ejs'
  \ 'css'
  \ 'less'
  \ 'md'
  \ 'markdown'
  \ 'json'
  \ 'js'
  \ 'jsx'
  \ 'rb'
  \ 'php'
  \ 'py'
  \ 'pyc'
  \ 'pyo'
  \ 'pyd'
  \ 'coffee'
  \ 'mustache'
  \ 'hbs'
  \ 'conf'
  \ 'ini'
  \ 'yml'
  \ 'bat'
  \ 'jpg'
  \ 'jpeg'
  \ 'bmp'
  \ 'png'
  \ 'gif'
  \ 'ico'
  \ 'twig'
  \ 'cpp'
  \ 'c++'
  \ 'cxx'
  \ 'cc'
  \ 'cp'
  \ 'c'
  \ 'hs'
  \ 'lhs'
  \ 'lua'
  \ 'java'
  \ 'sh'
  \ 'fish'
  \ 'ml'
  \ 'mli'
  \ 'diff'
  \ 'db'
  \ 'sql'
  \ 'dump'
  \ 'clj'
  \ 'cljc'
  \ 'cljs'
  \ 'edn'
  \ 'scala'
  \ 'go'
  \ 'dart'
  \ 'xul'
  \ 'sln'
  \ 'suo'
  \ 'pl'
  \ 'pm'
  \ 't'
  \ 'rss'
  \ 'f#'
  \ 'fsscript'
  \ 'fsx'
  \ 'fs'
  \ 'fsi'
  \ 'rs'
  \ 'rlib'
  \ 'd'
  \ 'erl'
  \ 'hrl'
  \ 'vim'
  \ 'ai'
  \ 'psd'
  \ 'psb'
  \ 'ts'
  \ 'jl'
)

exact_match_folders=(
  \ 'dropbox'
  \ 'node_modules'
)

exact_matches=(
  \ 'gruntfile.coffee'
  \ 'gruntfile.js'
  \ 'gruntfile.ls'
  \ 'gulpfile.coffee'
  \ 'gulpfile.js'
  \ 'gulpfile.ls'
  \ '.ds_store'
  \ '.gitconfig'
  \ '.gitignore'
  \ '.bashrc'
  \ '.bashprofile'
  \ 'favicon.ico'
  \ 'license'
  \ 'react.jsx'
  \ 'procfile'
)

test_files=(
  \ '112.123.111.js'
  \ '.112.123.111.js'
  \ 'file123.js123.js'
  \ 'file.js'
  \ '112.js'
  \ '_file.js'
  \ 'hyphen-file.js'
  \ 'hyphen-file.hyphen-file.js'
  \ '-.hyphen-file.js'
  \ '**%%44#@@!!@##$!!#!.error.js'
)

pattern_matches=(
  \ 'test.angular.js'
  \ 'test.backbone.js'
  \ 'test.jquery.js'
  \ 'test.materialize.css'
  \ 'test.materialize.js'
  \ 'test.mootools.js'
  \ 'test.require.js'
)

mkdir -p './files/normal/extensions'
mkdir -p './files/normal/exact_matches'
mkdir -p './files/normal/pattern_matches'
mkdir -p './files/normal/test_files'
mkdir -p './files/executable/extensions'
mkdir -p './files/executable/exact_matches'
mkdir -p './files/executable/pattern_matches'
mkdir -p './files/executable/test_files'

for exact_match_folder in ${exact_match_folders[@]}
do
	mkdir -p "files/normal/exact_matches/$exact_match_folder"
	mkdir -p "files/executable/exact_matches/$exact_match_folder"
done

for exact_match in ${exact_matches[@]}
do
  touch "files/normal/exact_matches/$exact_match"
  touch "files/executable/exact_matches/$exact_match"
	chmod +x "files/executable/exact_matches/$exact_match"
done

for extension in ${extensions[@]}
do
  touch "files/normal/extensions/$extension.$extension"
  touch "files/executable/extensions/$extension.$extension"
  chmod +x "files/executable/extensions/$extension.$extension"
done

for test_file in ${test_files[@]}
do
  touch "files/normal/test_files/$test_file"
  touch "files/executable/test_files/$test_file"
  chmod +x "files/executable/test_files/$test_file"
done

for pattern_match in ${pattern_matches[@]}
do
  touch "files/normal/pattern_matches/$pattern_match"
  touch "files/executable/pattern_matches/$pattern_match"
  chmod +x "files/executable/pattern_matches/$pattern_match"
done
