" We don't need vi compatibility but vim power
set nocompatible


" Vundle Bundle
""""""""""""""""

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage itself
Bundle 'vundle'

" Vim funtionality
"Bundle 'multvals.vim'
"Bundle 'ScrollColors'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'The-NERD-Commenter'
Bundle 'bufexplorer.zip'
Bundle 'SuperTab-continued.'
Bundle 'IndexedSearch'
Bundle 'bufexplorer.zip'

" New functionality
Bundle 'msanders/snipmate.vim'
Bundle 'chrisbra/Recover.vim'
Bundle 'skammer/vim-css-color'
Bundle 'scrooloose/syntastic'
Bundle 'The-NERD-tree'
Bundle 'Conque-Shell'
Bundle 'jamessan/vim-gnupg'
Bundle 'scrooloose/syntastic'

" SCM
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'gmarik/github-search.vim'

" C/C++ stuff
Bundle 'vim-scripts/c.vim'
Bundle 'derekwyatt/vim-protodef'
Bundle 'majutsushi/tagbar'

" Web development
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'edsono/vim-dbext'
Bundle 'sukima/xmledit'
Bundle 'matthias-guenther/hammer.vim'
Bundle 'XML-Folding'

" Color schemes
Bundle 'tpope/vim-vividchalk'
Bundle 'wombat256.vim'
"Bundle 'Color-Sampler-Pack'


" GVim options
"""""""""""""""

if has("gui_running")
	set guifont=DroidSansMono\ 13
	set guioptions-=T
endif


" Automagical autocmd's
""""""""""""""""""""""""

if has("autocmd")
	" Language specific indentation
	augroup syntax
		au FileType ruby setl et ts=2 sw=2 sts=2 | silent color vividchalk
		au FileType sh setl et ts=2 sw=2 sts=2
		au FileType xml setl et ts=2 sw=2 sts=2
		au FileType python setl et
		au FileType haskell setl et ts=8 sw=4 sts=4 sta sr nojs
		au FileType java setl makeprg=mvn\ package
	augroup END

	" search project root
	"au BufRead * SetProject()

	" Highlight unwanted whitespaces
	"highlight ExtraWhitespace ctermbg=red guibg=red
	"syntax match ExtraWhitespace /\s\+$\| \+\ze\t\|[^\t]\zs\t\+/
	"au BufWinEnter * syntax match ExtraWhitespace /\s\+$\| \+\ze\t\|[^\t]\zs\t\+/
	"au BufWinLeave * syntax clear ExtraWhitespace

	" Open every buffer in own tab
	" note: this breaks :help and ctrl+]
	"au BufAdd,BufNewFile,BufRead * nested tab sball

	" Reload vimrc when edited
	au! BufWritePost vimrc source ~/.vimrc

	" Cursorline only in current window
	augroup cursor
		au!
		au WinLeave * set nocursorline colorcolumn=0
		au WinEnter * set cursorline colorcolumn=80
	augroup END

	" Trailing whitespaces in normal mode
	augroup trailing
		au!
		au InsertEnter * :set listchars-=trail:␣
		au InsertLeave * :set listchars+=trail:␣
	augroup END

	" Open NERDTree in empty windows
	if has("NERDTree")
		au vimenter * ToggleNerdTree()
	endif

	" Remove trailing whitespaces on save
	au BufWritePre * :%s/\s\+$//e
endif


" Custom keymap activator
let mapleader=','

" Hide buffers instead of closing
set nohidden

" Visual
set background=dark
color wombat256mod
set title			" change window title
set number			" line numbers
set cursorline		" highlight line where cursor is
set colorcolumn=80	" column marker
set showmode		" display edit mode
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:␣ ",eol:¬
set showbreak=↪

" Indentation settings
set cin			" C-style indentation
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set foldlevelstart=0

" Search settings
set ignorecase
set smartcase		" ignore case only when pattern is all lowercase
set hlsearch		" highlight search results

" Better file name completion
set wildmode=longest:full
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,__pythom__,tmp,*.scssc

" 1001 undo levels
set undolevels=1001

" cd magic
"set autochdir " this breaks project path settings

" Proper shell
if executable('/bin/zsh')
	set shell=/bin/zsh
endif


" Plugins
"""""""""""

" BufExplorer
let g:bufExplorerSortBy='fullpath'
let g:bufExplorerShowRelativePath=1

" XMLEdit
"let xml_use_xhtml=1

" NERDTree
let g:NERDTreeWinPos="right"

" Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_branch_prefix = ''
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled=1

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1


" Keybindings
"""""""""""""""

" Ack
nnoremap <leader>a :Ack

" Show bufExplorer
map <f9> <c-o>:BufExplorer<cr>

" Toggle NERDTree
map <f10> :execute 'NERDTreeToggle '.getcwd()<cr>

" Toggle visual hints
nmap <silent> <leader>hl :se invhlsearch<cr>
nmap <silent> <leader>cc :call ToggleColumn()<cr>

" Window navigation
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-tab> <c-w>w


" Quit/save/reload
map <c-q> <c-o>:q<cr>
map <c-s> <c-o>:w<cr>
map <c-r> <c-o>:e!<cr>

" Tab controls
map <c-t> :tabnew<cr>
map <c-x> :tabclose<cr>
nnoremap <silent> <right> :bnext<cr>
nnoremap <silent> <left> :bprev<cr>

" CTRL-Y to switch to alternative buffer
map <c-y> :b#<cr>

" Quickly edit/reload vimrc file
nmap <silent> <leader>cfg :e $MYVIMRC<cr>
nmap <silent> <leader>rl :so $MYVIMRC<cr>

" Map . to : for fast commands (deDE layout)
nnoremap . :

" Map up/down to page-up/-down
map <up> <C-B>
map <down> <C-F>

" Don't step over wrapped lines
nnoremap j gj
nnoremap k gk

" Delete words
imap <silent> <c-d> <c-[>diwi

" Save as root
cmap w!! %!sudo tee > /dev/null %

" Autospace
inoremap <= <space><=<space>
inoremap >= <space>>=<space>
inoremap *= <space>*=<space>
inoremap /= <space>/=<space>
inoremap >> <space>>><space>
inoremap << <space><<<space>
inoremap == <space>==<space>
inoremap += <space>+=<space>
inoremap -= <space>-=<space>
inoremap && <space>&&<space>
inoremap != <space>!=<space>


" Custom commands
""""""""""""""""""

function! ToggleColumn()
	if &colorcolumn == 80
		let &colorcolumn = 0
	else
		let &colorcolumn = 80
	endif
endfunction


function! ToggleNerdTree()
	if argc()
		if isdirectory(argv(0))
			exe "cd" argv(0)
		else
			return
		endif
	endif
	NERDTree
endfunction

"function! SetProject()
"	let markers = [".cvs",".svn", ".git", ".hg", "Makefile", "pom.xml",
"	"Scons.py"]
"endfunction
