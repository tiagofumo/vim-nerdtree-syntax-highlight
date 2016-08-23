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

if [ ! -d "./files/" ]; then
  mkdir './files'
fi

if [ ! -d "./files/extensions/" ]; then
  mkdir './files/extensions'
fi

if [ ! -d "./files/exact_matches/" ]; then
  mkdir './files/exact_matches'
fi

for extension in ${extensions[@]}
do
  touch "files/extensions/$extension.$extension"
done

for exact_match in ${exact_matches[@]}
do
  touch "files/exact_matches/$exact_match"
done

for exact_match_folder in ${exact_match_folders[@]}
do
  if [ ! -d "./files/exact_matches/$exact_match_folder/" ]; then
    mkdir "./files/exact_matches/$exact_match_folder"
  fi
done

if [ ! -d "./files/test_files/" ]; then
  mkdir './files/test_files'
fi

for test_file in ${test_files[@]}
do
  touch "files/test_files/$test_file"
done

if [ ! -d "./files/pattern_matches/" ]; then
  mkdir './files/pattern_matches'
fi

for pattern_match in ${pattern_matches[@]}
do
  touch "files/pattern_matches/$pattern_match"
done
