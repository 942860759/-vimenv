set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'google/yapf', { 'rtp': 'plugins/vim' }
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'} " :YcmGenerateConfig or :CCGenerateConfig commands to generate a config
" Plugin 'davidhalter/jedi-vim'   " Python auto complete
" Plugin 'ervandew/supertab'      " use <Tab> for jedi-vim auto complete
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'dense-analysis/ale'  " Check syntax in Vim
Plugin 'moll/vim-bbye'       " <leader>q close buffer
Plugin 'vim-scripts/ZoomWin' " <c-w>o zoom in/out windown
Plugin 'octol/vim-cpp-enhanced-highlight'

call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nu
set nowrap
set hlsearch
set encoding=utf-8
set updatetime=5000
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set cursorline
" set cursorcolumn
filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set foldmethod=syntax
set nofoldenable
set completeopt-=preview
set term=xterm-256color

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|term://|undotree|vimfiler'
let g:airline_extensions = ['tabline'] " only the extensions listed will be loaded; an empty array would effectively disable all extensions
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1
let g:jedi#documentation_command = ""
let g:jedi#popup_select_first = 0
" <tab> navigate the completion menu from top to bottom
let g:SuperTabDefaultCompletionType = "<c-n>"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Change the default mapping and the default command to invoke CtrlP:
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
" nmap <F6> :CtrlPMixed<CR>
" nmap <F7> :CtrlPBuffer<CR>
" Exclude files and directories using Vim's wildignore and CtrlP's own g:ctrlp_custom_ignore. 
" If a custom listing command is being used, exclusions are ignored:
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" open a NERDTree automatically when vim starts up
autocmd vimenter * if !argc() | NERDTree | wincmd l | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd Filetype json let g:indentLine_setConceal = 0

" open NERDTree with Ctrl+n 
map <F3> :NERDTreeToggle<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>s <C-W>s
nmap <leader>v <C-W>v
nmap <leader>b :CtrlPBuffer<CR>
nmap <F5> :term bash<CR>
nmap <F8> :TagbarToggle<CR>
"split navigations
nnoremap <Tab> <C-W><C-W>
" bind K to grep word under cursor
nnoremap K :grep! -nR "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <Leader>q :Bdelete<CR>
nnoremap <Leader>lw <C-W>l
nnoremap <Leader>hw <C-W>h
nnoremap <Leader>kw <C-W>k
nnoremap <Leader>jw <C-W>j
nnoremap <Leader>a :Ack!<Space>
nnoremap <leader>j :YcmCompleter GoTo<CR>
vnoremap < <gv
vnoremap > >gv
tnoremap <C-W>n <C-W>N

" jedi-vim
" Completion <C-Space>
" Goto assignment <leader>g (typical goto function)
" Goto definition <leader>d (follow identifier as far as possible, includes imports and statements)
" Goto (typing) stub <leader>s
" Show Documentation/Pydoc K (shows a popup with assignments)
" Renaming <leader>r
" Usages <leader>n (shows all the usages of a name)
" Open module, e.g. :Pyimport os (opens the os module)

" I don't want to jump to the first result automatically.
cnoreabbrev Ack Ack!

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
