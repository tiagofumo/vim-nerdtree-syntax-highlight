extensions=(
   'styl'
   'sass'
   'scss'
   'htm'
   'html'
   'erb'
   'slim'
   'ejs'
   'css'
   'less'
   'md'
   'mdx'
   'markdown'
   'rmd'
   'json'
   'js'
   'mjs'
   'jsx'
   'rb'
   'php'
   'py'
   'pyc'
   'pyo'
   'pyd'
   'coffee'
   'mustache'
   'hbs'
   'conf'
   'ini'
   'yml'
   'yaml'
   'toml'
   'bat'
   'jpg'
   'jpeg'
   'bmp'
   'png'
   'webp'
   'gif'
   'ico'
   'twig'
   'cpp'
   'c++'
   'cxx'
   'cc'
   'cp'
   'c'
   'cs'
   'h'
   'hh'
   'hpp'
   'hxx'
   'hs'
   'lhs'
   'lua'
   'java'
   'sh'
   'fish'
   'bash'
   'zsh'
   'ksh'
   'csh'
   'awk'
   'ps1'
   'ml'
   'mli'
   'diff'
   'db'
   'sql'
   'dump'
   'clj'
   'cljc'
   'cljs'
   'edn'
   'scala'
   'go'
   'dart'
   'xul'
   'sln'
   'suo'
   'pl'
   'pm'
   't'
   'rss'
   'f#'
   'fsscript'
   'fsx'
   'fs'
   'fsi'
   'rs'
   'rlib'
   'd'
   'erl'
   'hrl'
   'ex'
   'exs'
   'eex'
   'leex'
   'vim'
   'ai'
   'psd'
   'psb'
   'ts'
   'tsx'
   'jl'
   'pp'
   'vue'
   'elm'
   'swift'
   'xcplayground'
)

exact_match_folders=(
   'dropbox'
   'node_modules'
)

exact_matches=(
   'gruntfile.coffee'
   'gruntfile.js'
   'gruntfile.ls'
   'gulpfile.coffee'
   'gulpfile.js'
   'gulpfile.ls'
   'mix.lock'
   '.ds_store'
   '.gitconfig'
   '.gitignore'
   '.bashrc'
   '.zshrc'
   '.vimrc'
   '.gvimrc'
   '_vimrc'
   '_gvimrc'
   '.bashprofile'
   'favicon.ico'
   'license'
   'react.jsx'
   'procfile'
   'dockerfile'
   'docker-compose.yml'
   'makefile'
   'cmakelists.txt'
   'Vagrantfile'
)

test_files=(
   '112.123.111.js'
   '.112.123.111.js'
   'file123.js123.js'
   'file.js'
   '112.js'
   '_file.js'
   'hyphen-file.js'
   'hyphen-file.hyphen-file.js'
   '-.hyphen-file.js'
   '**%%44#@@!!@##$!!#!.error.js'
   'file with spaces.js'
   'without_extension'
)

pattern_matches=(
   'test.angular.js'
   'test.backbone.js'
   'test.jquery.js'
   'test.materialize.css'
   'test.materialize.js'
   'test.mootools.js'
   'test.require.js'
   '.test.vimrc.test'
)

mkdir -p './files/normal/extensions'
mkdir -p './files/normal/exact_matches'
mkdir -p './files/normal/pattern_matches'
mkdir -p './files/normal/test_files'
mkdir -p './files/normal/without_extension'
mkdir -p './files/executable/extensions'
mkdir -p './files/executable/exact_matches'
mkdir -p './files/executable/pattern_matches'
mkdir -p './files/executable/test_files'
mkdir -p './files/executable/without_extension'

for exact_match_folder in "${exact_match_folders[@]}"
do
  mkdir -p "files/normal/exact_matches/$exact_match_folder"
  mkdir -p "files/executable/exact_matches/$exact_match_folder"
done

for exact_match in "${exact_matches[@]}"
do
  touch "files/normal/exact_matches/$exact_match"
  touch "files/executable/exact_matches/$exact_match"
done
chmod -R +x "files/executable/exact_matches/"

for extension in "${extensions[@]}"
do
  touch "files/normal/extensions/$extension.$extension"
  touch "files/executable/extensions/$extension.$extension"
done
chmod -R +x "files/executable/extensions/"

for test_file in "${test_files[@]}"
do
  touch "files/normal/test_files/$test_file"
  touch "files/executable/test_files/$test_file"
done
chmod -R +x "files/executable/test_files/"

for pattern_match in "${pattern_matches[@]}"
do
  touch "files/normal/pattern_matches/$pattern_match"
  touch "files/executable/pattern_matches/$pattern_match"
done
chmod -R +x "files/executable/pattern_matches/"

for i in {1..50}
do
  touch "files/normal/without_extension/file$i"
  touch "files/executable/without_extension/file$i"
done
chmod -R +x "files/executable/without_extension/"
