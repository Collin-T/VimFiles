setlocal spell
setlocal tabstop=4
setlocal shiftwidth=4
setlocal conceallevel=0
setlocal matchpairs={:},(:)

nnoremap <F1> :! pdflatex -synctex=1 -interaction=nonstopmode *.tex<CR>
inoremap <F1> <C-o>:! pdflatex -synctex=1 -interaction=nonstopmode *.tex<CR>
