"Basic graphics
	"Enable language specific functionality. Could also be put in general
	filetype on
	filetype plugin on
	filetype indent on
	syntax on

	set nohlsearch
	"Theme
	colorscheme Tomorrow-Night-Eighties
	set guifont=Noto\ Sans:h18

	"Show line number
	set number
	set relativenumber

	"Neovim spellbad set to red
	hi SpellBad ctermbg=160

	"Redraw screen (in case highlights stick for whatever reason)
	nnoremap zr :syntax on<CR> 

	set tabstop=4 shiftwidth=4
	set signcolumn=yes
	



"General functionality
	"Bettery History
	set hidden
	set history=100

	" Resize buffer easier
	nmap ! <c-w><
	nmap # <c-w>>

	"Map ` to common macro
	"This may very well be my favorite modification
	vnoremap ` :norm @q<cr>
	nnoremap ` @q

	"Encode using utf8
	set encoding=utf8

	"Indentation
	set autoindent
	set smartindent
	set cindent

	"Code folding
	nnoremap <space> za

	"Remove C-W in buffer switching commands
	nnoremap <C-H> <C-W><C-H>
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>

	map <S-Del> <Del>

	"Quickly reload vimrc
	map <leader>s :source ~/.vimrc<CR>

	"Set python executable for neoivm
	let g:python_host_prog = '/usr/bin/python2'
	let g:python3_host_prog = '/usr/bin/python3'

"Plugins
"Only load basic plugins in vim, and load the rest in neovim
"Only load in neovim (shortens vim load time)
if has('nvim')

"Manage plugins
	call plug#begin()

	Plug 'editorconfig/editorconfig-vim'

	Plug 'vim-vdebug/vdebug'

	Plug 'vim-scripts/dbext.vim'

	Plug 'tikhomirov/vim-glsl'
	Plug 'shmup/vim-sql-syntax'


	Plug 'rhysd/vim-grammarous'

	Plug 'scrooloose/nerdtree'

	Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

	Plug 'junegunn/vim-easy-align'

	Plug 'terryma/vim-multiple-cursors'
	Plug 'honza/vim-snippets'

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	Plug 'junegunn/fzf.vim'

	Plug 'itchyny/lightline.vim'

	Plug 'tpope/vim-fugitive'

	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'

	Plug 'rhysd/vim-clang-format'

	Plug 'lervag/vimtex'

	call plug#end()

"Plugin Options
	"coc
		" Use `[c` and `]c` to navigate diagnostics
		nmap <silent> [c <Plug>(coc-diagnostic-prev)
		nmap <silent> ]c <Plug>(coc-diagnostic-next)

		" Remap keys for gotos
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)

		" Use K to show documentation in preview window
		nnoremap <silent> K :call <SID>show_documentation()<CR>

		function! s:show_documentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			else
				call CocAction('doHover')
			endif
		endfunction	

		nmap <leader>rn <Plug>(coc-rename)

		xmap <leader>f  <Plug>(coc-format-selected)
		nmap <leader>f  <Plug>(coc-format-selected)

		xmap <leader>a  <Plug>(coc-codeaction-selected)
		nmap <leader>a  <Plug>(coc-codeaction-selected)

		" Remap for do codeAction of current line
		nmap <leader>ca  <Plug>(coc-codeaction)
		" Fix autofix problem of current line
		nmap <leader>qf  <Plug>(coc-fix-current)
		
	"Fzf 
		"file search bound to control p (out of familiarity
		nnoremap <C-P> :Files<CR>
		"buffer search bound to ~
		nnoremap ~ :Buffers<CR>

	"NERDTree
		"Open and toggle tree
		nnoremap <leader>n :NERDTreeFocus<CR>
		nnoremap <leader><S-n> :NERDTreeToggle<CR>

		let NERDTreeShowHidden=1

	"neosnippet
		let g:neosnippet#expand_word_boundary = 1
		imap <c-j> <Plug>(neosnippet_expand_or_jump)
		smap <c-j> <Plug>(neosnippet_expand_or_jump)
		xmap <c-j> <Plug>(neosnippet_expand_target)

	"vim-clang-format
		vnoremap <leader>z :ClangFormat<CR>

	"vim-easy-align
		xmap ga <Plug>(EasyAlign)
		nmap ga <Plug>(EasyAlign)

	"vim-grammarous
		nmap <leader>g <Plug>(grammarous-move-to-info-window)

	"Vim Multiple Cursors
		nmap <leader>f :MultipleCursorsFind 
		let g:multi_cursor_exit_from_insert_mode = 0
		let g:multi_cursor_exit_from_visual_mode = 0
	
	"Vim-plug
		"Install and update
		map <leader>i :PlugInstall<CR>
		map <leader>c :PlugClean<CR>
		map <leader>u :PlugUpdate<CR>

endif
