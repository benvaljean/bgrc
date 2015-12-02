" bgvimrc
" https://github.com/benvaljean/bgrc
"
" Caution: Manual changes are lost when upgrading

"Abort if using evim
if v:progname =~? "evim"
	finish
endif

filetype on

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endi

set autoindent
set ignorecase
set smartcase
set incsearch
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set history=50
set ruler
set showcmd		  " show incomplete commands

set copyindent    " copy the previous indentation on autoindenting
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting

set pastetoggle=<F2>

set confirm

"Backups are annoying in conf.d type areas
set nobackup

" Allow ; instead of : for commands
nnoremap ; :
" Use ,/ to clear search highlight
nmap <silent> ,/ :nohlsearch<CR>

" Allow :w!! to re-open the file with sudo
cmap w!! w !sudo tee % >/dev/null

" http://nvie.com/posts/how-i-boosted-my-vim/

" If I forget to use the ; : cmap I have a bad habit of entering :Q!
cmap Q q

" allow quick exit no save
cmap qq q!

call pathogen#infect()

""NERDTtree
" Autoload NERDTree if no file is specificed
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"Disable / reenable NERDTree
map <C-n> :NERDTreeToggle<CR>
" Exit vim if only NREDTree is left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"Never re-open the same file twice
set switchbuf=useopen,usetab
"Show hidden files
let NERDTreeShowHidden=1

"Solorized colours
"git clone git://github.com/altercation/vim-colors-solarized.git
syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

"Show whitespace: trailing space as ~ , tab as >--
"To enable  :set list
"To disable  :set nolist
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
