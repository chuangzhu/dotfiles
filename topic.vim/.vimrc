
set encoding=utf-8

syntax on
" display line numbers
set nu

" disable bells
set belloff=all
" enable clicking, selecting
set mouse=a

" status bar and command complete
set wildmenu
set laststatus=2

" hightlight search
set incsearch

" indent
filetype indent plugin on
set smartindent autoindent
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd BufNewFile,BufRead *.c,*.h set tabstop=4 cindent noexpandtab
autocmd BufNewFile,BufRead *.cpp,*.cxx,*.hpp,*.hxx set cindent 
autocmd BufNewFile,BufRead Makefile,makefile set shiftwidth=8 softtabstop=8 noexpandtab
autocmd BufNewFile,BufRead *.html,*.scss,*.css,*.js,*.json set shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.js,*.json set cindent
autocmd BufNewFile,BufRead *.wxml,*.wxss,*.wxs set shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.py set tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.go set tabstop=4 cindent noexpandtab
autocmd BufNewFile,BufRead .gitconfig set shiftwidth=8 noexpandtab

" highlight
autocmd BufNewFile,BufRead *.wxml set syn=html
autocmd BufNewFile,BufRead *.wxss set syn=css
autocmd BufNewFile,BufRead *.wxs set syn=javascript

" completion

au FileType html setl ofu=htmlcomplete#CompleteTags

filetype plugin on
set omnifunc=syntaxcomplete#Complete

inoremap <C-@> <C-Space>

