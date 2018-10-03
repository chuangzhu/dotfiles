
" high light
syntax on

" display line numbers
set nu

" disable bells
set belloff=all

set encoding=utf-8

" indent
set smartindent
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd BufNewFile,BufRead *.c,*.h set tabstop=4 cindent noexpandtab
autocmd BufNewFile,BufRead *.cpp,*.cxx set cindent 
autocmd BufNewFile,BufRead Makefile,makefile set shiftwidth=8 softtabstop=8 noexpandtab
autocmd BufNewFile,BufRead *.html,*.css,*.js,*.json set shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.js,*.json set cindent
autocmd BufNewFile,BufRead *.wxml,*.wxss,*.wxs set shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.py set cindent
autocmd BufNewFile,BufRead *.go set tabstop=4 cindent noexpandtab

" highlight
autocmd BufNewFile,BufRead *.wxml set syn=html
autocmd BufNewFile,BufRead *.wxss set syn=css
autocmd BufNewFile,BufRead *.wxs set syn=javascript

