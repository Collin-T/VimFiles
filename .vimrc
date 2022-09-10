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

	"Wrapping
	set wrap
	set linebreak

	"Neovim spellbad set to red
	hi SpellBad ctermbg=160

	"Redraw screen (in case highlights stick for whatever reason)
	nnoremap zr :syntax on<CR>

	set tabstop=4 shiftwidth=4
	set signcolumn=yes

	"Force spawning an alacritty terminal with neovim work correctly by
	"sending SIGWINCH
	if !empty($ALACRITTY_LOG)
		autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
	endif




"General functionality
	"Bettery History
	set hidden
	set history=100

	set nojoinspaces
	set mouse=a

	" Go back (to previous file) with gb
	nnoremap gb <c-^>

	nmap <F1> <nop>
	imap <F1> <nop>
	nmap Q <nop>

	if executable("rg")
		set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
	endif

	" Resize buffer easily
	nnoremap g! !
	nnoremap ! <c-w><
	nnoremap g# #
	nnoremap # <c-w>>

	"Map ` to common macro
	"This may very well be my favorite modification
	vnoremap ` :norm @q<cr>
	nnoremap ` @q

	"Encode using utf8
	set encoding=utf-8

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
	imap <S-Del> <Del>

	"Quickly reload vimrc
	map <leader>s :source ~/.vimrc<CR>

	"Set python executable for neoivm
	let g:python_host_prog = 'python2'
	let g:python3_host_prog = 'python3'

"Plugins
"Only load basic plugins in vim, and load the rest in neovim
"Only load in neovim (shortens vim load time)
if has('nvim')

"Manage plugins
	call plug#begin()

	" Plug 'kbenzie/vim-spirv'

	Plug 'christoomey/vim-tmux-navigator'

	Plug 'jeetsukumaran/vim-indentwise'

	Plug 'editorconfig/editorconfig-vim'

	" Plug 'shmup/vim-sql-syntax'
	" Plug 'petRUShka/vim-opencl'
	"Optional, just quality of life
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'rhysd/vim-grammarous'

	Plug 'scrooloose/nerdtree'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'puremourning/vimspector'

	Plug 'junegunn/vim-easy-align'

	" Plug 'terryma/vim-multiple-cursors'
	Plug 'honza/vim-snippets'

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'

	Plug 'junegunn/fzf.vim'

	Plug 'itchyny/lightline.vim'

	Plug 'tpope/vim-fugitive'

	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'

	call plug#end()

"Plugin Options
	"coc
		" Use `[c` and `]c` to navigate diagnostics
		nmap <silent> [c <Plug>(coc-diagnostic-prev)
		nmap <silent> ]c <Plug>(coc-diagnostic-next)

		" Remap keys for gotos
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gD :sp<CR><Plug>(coc-definition)
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

		" Fix common typo (otherwise :W gives :Windows from fzf.vim)
		command! W write

		" The only thing keeping me sane
		" greps the entire project for the word under the cursor
		" it's not intellisense, but it works. mostly
		nmap & :Rg <C-R>=expand("<cword>")<CR><CR>

	"NERDTree
		"Open and toggle tree
		nnoremap <leader>n :NERDTreeFocus<CR>
		nnoremap <leader><S-n> :NERDTreeToggle<CR>

		let NERDTreeMinimalUI=1
		let NERDTreeShowHidden=1

	"neosnippet
		let g:neosnippet#expand_word_boundary = 1
		let g:neosnippet#snippets_directory = "~/.vim/plugged/neosnippet-snippets/neosnippets"
		imap <c-j> <Plug>(neosnippet_expand_or_jump)
		smap <c-j> <Plug>(neosnippet_expand_or_jump)
		xmap <c-j> <Plug>(neosnippet_expand_target)

	"Nvim-R
		let R_assign = 0

	"nvim-treesitter
		let g:tex_flavor = 'latex'
		let g:tex_noindent_env = 'document\|verbatim\|enumerate\|itemize\|lstlisting\|frame'
		let g:tex_indent_items = 0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "elixir", "python", "latex", "javascript", "toml", "glsl" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false
  }
}
EOF

	"vim-easy-align
		xmap ga <Plug>(EasyAlign)
		nmap ga <Plug>(EasyAlign)

	"vim-grammarous
		nmap <leader>g <Plug>(grammarous-move-to-info-window)
		let g:grammarous#languagetool_cmd = 'languagetool'
		command! -range Gr GrammarousCheck

	"Vim Multiple Cursors
		nmap <leader>f :MultipleCursorsFind
		let g:multi_cursor_exit_from_insert_mode = 0
		let g:multi_cursor_exit_from_visual_mode = 0

	"Vim-plug
		"Install and update
		map <leader>i :PlugInstall<CR>
		map <leader>c :PlugClean<CR>
		map <leader>u :PlugUpdate<CR>

	"Vimspector
		let g:vimspector_enable_mappings = "HUMAN"

endif
