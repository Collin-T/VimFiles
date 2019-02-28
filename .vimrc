"Basic graphics
	"Enable language specific functionality. Could also be put in general
	syntax on
	filetype on
	filetype indent on
	filetype plugin on

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

	Plug 'tikhomirov/vim-glsl'

	Plug 'rhysd/vim-grammarous'

	Plug 'scrooloose/nerdtree'

	Plug 'autozimu/LanguageClient-neovim', {
	    \ 'branch': 'next',
	    \ 'do': './install.sh',
	    \ }

	Plug 'roxma/nvim-yarp'
	Plug 'ncm2/ncm2'
	Plug 'ncm2/ncm2-neosnippet'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'

	Plug 'junegunn/vim-easy-align'

	Plug 'terryma/vim-multiple-cursors'
	Plug 'honza/vim-snippets'

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	Plug 'itchyny/lightline.vim'

	Plug 'tpope/vim-fugitive'

	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'

	Plug 'rhysd/vim-clang-format'

	Plug 'xuhdev/vim-latex-live-preview'

	call plug#end()

"Plugin Options
	"Fzf 
		"file search bound to control p (out of familiarity
		nnoremap <C-P> :Files<CR>
		"buffer search bound to ~
		nnoremap ~ :Buffers<CR>

	"LanguageClient
		"Load context menu with F5
		nnoremap <F5> :call LanguageClient_contextMenu()<CR>
		nnoremap <F4> :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
		nnoremap K :call LanguageClient#textDocument_hover()<CR>

		"Language server commands
		let g:LanguageClient_serverCommands = {
					\'c':          ['ccls', '--log-file=/tmp/ccls.log'],
					\'cpp':        ['ccls', '--log-file=/tmp/ccls.log'],
					\'cuda':        ['ccls', '--log-file=/tmp/ccls.log'],
					\'javascript': ['javascript-typescript-stdio'],
					\'python':     ['pyls']}
		
		let g:LanguageClient_loadSettings = 1 

		set completefunc=LanguageClient#complete

		set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
		let g:LanguageClient_windowLogMessageLevel = "Info"

		let g:LanguageClient_autoStart = 1
		augroup LanguageClient_sign_column
			autocmd!
			autocmd FileType c,cpp,python,javascript setlocal signcolumn=yes
		augroup END

		let g:LanguageClient_useVirtualText = 0

	"Lightline

	"NCM2
		autocmd BufEnter * call ncm2#enable_for_buffer()
		set completeopt=noinsert,menuone,noselect

		let g:ncm2#auto_popup = 0
		inoremap <c-a> <c-r>=ncm2#manual_trigger()<cr>

		function! NCM2ExpandCompletionIfSnippet()
			if ncm2_neosnippet#completed_is_snippet()
				call feedkeys("\<Plug>(ncm2_neosnippet_expand_completed)", "im")
				return ''
			endif
			return ''
		endfunction

		autocmd CompleteDone * call NCM2ExpandCompletionIfSnippet()

	"NERDTree
		"Open and toggle tree
		nnoremap <leader>n :NERDTreeFocus<CR>
		nnoremap <leader><S-n> :NERDTreeToggle<CR>

		let NERDTreeShowHidden=1

	"neosnippet
		if has('conceal')
		  set conceallevel=2 concealcursor=niv
		endif
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

	"vim-latex-live-preview
		let g:livepreview_cursorhold_recompile = 0

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
