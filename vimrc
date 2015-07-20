" We don't need vi compatibility but vim power
set nocompatible


" Vundle Plugin
""""""""""""""""

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Vim funtionality
"Plugin 'multvals.vim'
"Plugin 'ScrollColors'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular'
Plugin 'The-NERD-Commenter'
Plugin 'bufexplorer.zip'
Plugin 'ervandew/supertab'
Plugin 'IndexedSearch'

" New functionality
Plugin 'garbas/vim-snipmate'
Plugin 'chrisbra/Recover.vim'
Plugin 'skammer/vim-css-color'
Plugin 'scrooloose/syntastic'
Plugin 'The-NERD-tree'
Plugin 'Conque-Shell'
Plugin 'jamessan/vim-gnupg'
Plugin 'dkprice/vim-easygrep'
Plugin 'yegappan/mru'
Plugin 'kien/ctrlp.vim'
Plugin 'taylor/vim-zoomwin'

" SCM
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'gmarik/github-search.vim'

" C/C++ stuff
Plugin 'vim-scripts/c.vim'
Plugin 'derekwyatt/vim-protodef'
Plugin 'majutsushi/tagbar'

" Web development
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
Plugin 'edsono/vim-dbext'
Plugin 'sukima/xmledit'
Plugin 'matthias-guenther/hammer.vim'
Plugin 'XML-Folding'

" Color schemes
Plugin 'tpope/vim-vividchalk'
Plugin 'wombat256.vim'
"Plugin 'Color-Sampler-Pack'

call vundle#end()
filetype plugin indent on


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
		au FileType ruby setl ts=2 sw=2 sts=2 | silent color vividchalk
		au FileType sh setl ts=2 sw=2 sts=2
		au FileType xml setl ts=4 sw=4 sts=4
		au FileType haskell setl ts=8 sw=4 sts=4 sta sr nojs
		au FileType java setl ts=4 sw=4 sts=4 makeprg=mvn\ package
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

try
    color wombat256mod
catch /^Vim\%((\a\+)\)\=:E185/
    " ignore if scheme doesn't exist
endtry

set title			" change window title
set number			" line numbers
set cursorline		" highlight line where cursor is
set colorcolumn=80	" column marker
set noshowmode		" hide mode
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
set expandtab

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
let g:airline_branch_prefix='⎇'
"let g:airline_symbols.branch = '⎇'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':p:.:gs?[^/]*/??'
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ }		" short modes

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" EasyGrep
let g:EasyGrepMode=2
let g:EasyGrepCommand=0
let g:EasyGrepRecursive=1
let g:EasyGrepIgnoreCase=1


" Keybindings
"""""""""""""""

" Ack
nnoremap <leader>a :Ack

" Show bufExplorer
map <f8> <c-o>:BufExplorer<cr>

" Toggle NERDTree
map <f9> :execute 'NERDTreeToggle '.getcwd()<cr>

" Toggle visual hints
nnoremap <silent> <leader>hl :se invhlsearch<cr>
nnoremap <silent> <leader>cc :call ToggleColumn()<cr>
nnoremap <silent> <leader>sx :call SyntaxBalloon()<cr>

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

function! CSVH(colnr)
    " make separator changeable
    let SEP=';'
    if a:colnr > 1
        let n = a:colnr - 1
        execute 'match Keyword /^\([^'.SEP.']*'.SEP.'\)\{'.n.'}\zs[^'.SEP.']*/'
        execute 'normal! 0'.n.'f,'
    elseif a:colnr == 1
        execute 'match Keyword /^[^'.SEP.']*/'
        normal! 0
    else
        match
    endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

function! SyntaxBalloon()
    let synID   = synID(v:beval_lnum, v:beval_col, 0)
    let groupID = synIDtrans(synID)
    let name    = synIDattr(synID, "name")
    let group   = synIDattr(groupID, "name")
    return name . "\n" . group
endfunction

