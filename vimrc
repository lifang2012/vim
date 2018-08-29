" tips
" :g/\v"\w+\.\w+"/norm! "Ayap
" :help non-greedy
" /bit.\{-}
" To get a newline, use \r. When searching for a newline, you’d still use \n
" :%s/,/\n/g 
" Over a range defined by marks a and b, operate on each line containing pattern. The operation is to replace each pattern2 with string.
" :'a,'bg/pattern/s/pattern2/string/gi
" Run a macro on matching lines (example assuming a macro recorded as 'q'):
" :g/pattern/normal @q
" <----------------------------  MuxiVim  --------------------------->
" dead simple neovim config
" neo1218 @ MIT License
" https://github.com/neo1218/muxivim

" <-----------------------  Plugins Management ---------------------->
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vim-plug
call plug#begin()
Plug 'terryma/vim-multiple-cursors'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'vim-scripts/VisIncr'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/neocomplete.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
" 对python进行代码补全
" Plug 'davidhalter/jedi-vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'szw/vim-maximizer'
"unite要用到这个插件
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
" Plug 'Valloric/YouCompleteMe'
" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'vim-scripts/peaksea'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'easymotion/vim-easymotion'
Plug 'dyng/ctrlsf.vim'
Plug 'rking/ag.vim'
Plug 'vim-scripts/a.vim'
call plug#end()

" <-----------------------  font & GUI ---------------------------->
if has("win32")
	" set guifont=Arial_monospaced_for_SAP:h10:cANSI
	set guifont=Courier_New:h12:cANSI
else
    " set guifont=Liberation\Mono\ 12
    set guifont=YaHei\Consolas\Hybrid\ 13
endif

runtime macros/matchit.vim

"安装tmux后终端启动vim时需要
" set term=screen
"windows chinese language
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set termencoding=utf-8
"下面这行会导致文件16进制转换时不正确"
set encoding=utf-8
language message zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if has("gui_running")
	" set guioptions-=m
	set guioptions-=T
    " no left-hand scrollbar
	set guioptions-=l
	set guioptions-=L
    " no right-hand scrollbar
	set guioptions-=r
	set guioptions-=R
    " use console style tabbed interface
    set guioptions-=e
    " use console dialogs instead of popups
    set guioptions+=c

	let psc_style='cool'
	colorscheme desert
else
	set background=dark
	set t_Co =256
	colorscheme desert
endif

" <-------------------------  Searching ----------------------------->
" use ag/pt/ack for grepping if available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --smart-case\ --skip-vcs-ignores\ --path-to-agignore=$HOME/.agignore
elseif executable('pt')
  set grepprg=pt\ --nogroup\ --nocolor\ --hidden\ --nocolor\ -e
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --nopager
endif
" <-------------------------  registers ----------------------------->
" 将搜索到的行聚合到文件末尾
let @t='nyyGp``'
" <-----------------------  Auto Command ---------------------------->
autocmd!
autocmd bufwritepost $MYVIMRC source $MYVIMRC
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=green guibg=green
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" <------------------------- Code Folding --------------------------->
set foldmethod=manual

" <---------------------------- Leader ------------------------------>
let mapleader = ","

" <----------------------------  Key Map ---------------------------->
nnoremap <Leader>c :vs $MYVIMRC<CR>
" nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap ; :
" nnoremap * *zzzv
" nnoremap # #zzzv
" nnoremap n nzzzv
" nnoremap N Nzzzv
" Also center the screen when jumping through the changelist
" nnoremap g; g;zz
" nnoremap g, g,zz
" tnoremap <Esc> <C-\><C-n>
inoremap jk <esc>

set pastetoggle=<F2>
set clipboard=unnamed
set bs=2

map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

vnoremap < <gv
vnoremap > >gv

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" <--------------------Parenthesis/bracket expanding------------------->
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>
vnoremap <C-y> "+y

" <---------------------------- Code Syntax --------------------------->
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" <--------------------- Tab set (important for pythoner) ------------->
set tabstop=4
set shiftwidth=4
set expandtab
vnoremap <space>%ret! 4 <space>op

" <--------------------------  More for Vim --------------------------->
set number                                               " show line num
set numberwidth=1                                         " number width
" set relativenumber                                     " relative number
set tw=80                                                   " text width
" set colorcolumn=80                             " colorful max text width
set wrap linebreak nolist                               " auto wrap line
" highlight ColorColumn ctermbg=233
"set 4 lines to the curors - when moving vertical..
set scrolloff=4

" <----------------------------  Format ------------------------------->
vmap Q gq
nmap Q gqap

" <----------------------------  Others ------------------------------->
set history=700
set undolevels=700

" <--------------------------- Search Setting ------------------------->
set hlsearch
set incsearch
set ignorecase
set smartcase

" <----------------- Disable stupid backup and swap files ------------->
set nobackup
set nowritebackup
set noswapfile

" <------------------------ vim-startify setting ---------------------->
let g:startify_custom_header = [
            \'    lifang',
            \]

" <-------------------------- Plugins Setting ------------------------->
" nerdtree
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
map <F3> :NERDTreeToggle<CR>

" vim-maximizer
let g:maximizer_default_mapping_key = '<F10>'

" TagBar setting
nmap <F8> :TagbarToggle<CR>

" vim-airline setting
set laststatus=2
" let g:airline_theme="tomorrow"
let g:airline_theme="simple"
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <C-N> :bn<CR>
nnoremap <C-M> :bp<CR>
set t_Co=256
let g:Powerline_symbols = 'fancy'

" jedi-vim setting
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" vim-minimap setting
let g:minimap_highlight='Visual'

" Python folding
set nofoldenable

" vim/indentLine setting
" set background=back

" delimitMate
au FileType python let b:delimitMate_nesting_quotes = ['"']

" vim-gundo
nnoremap <F5> :GundoToggle<CR>

" vim-commentary
autocmd FileType apache setlocal commentstring=#\ %s

" modelsim的脚本文件尾缀.do, 是tcl语法
au BufRead,BufNewFile *.do set filetype=tcl

" ctrlp
" 用处: 
" 1. 查找当前目录下的文件
" 2. 工程查找，前提是工程用了版本控制，如git
" 3. 查找已经打开的buffer
" Open file menu
nnoremap <Leader>f :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
\ 'dir': '__pycache__$',
\ 'file': '\v\.(pyc)$',
\ }

" ctrlsf
" 用处: 
" 搜索字符，并能显示上下文
nmap     <Leader>sf <Plug>CtrlSFPrompt
" search selected
vmap     <Leader>sf <Plug>CtrlSFVwordPath
" search selected immediately
vmap     <Leader>sF <Plug>CtrlSFVwordExec
" search word under the cursor
" nmap     <Leader>sn <Plug>CtrlSFCwordPath
nmap     8 <Plug>CtrlSFCwordPath<CR>
" search the last pattern of vim
nmap     <Leader>sp <Plug>CtrlSFPwordPath
nnoremap <Leader>so :CtrlSFOpen<CR>
nnoremap <Leader>st :CtrlSFToggle<CR>
" inoremap <Leader>t <Esc>:CtrlSFToggle<CR>
nmap     <Leader>sl <Plug>CtrlSFQuickfixPrompt
vmap     <Leader>sl <Plug>CtrlSFQuickfixVwordPath
vmap     <Leader>sL <Plug>CtrlSFQuickfixVwordExec
" prevent close automatically
let g:ctrlsf_auto_close = 0
" 传入命令的额外参数
let g:ctrlsf_extra_backend_args = {
    \ 'pt': '--home-ptignore'
    \ }

let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ "openb": "",
    \ }

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" `s{char}{label}`
nmap f <Plug>(easymotion-overwin-f)
" `s{char}{char}{label}`
" nmap s <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" vim-easy-align-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_python_checkers = ['pylint']
" youcompleteme
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
"默认配置文件路径"
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
"python解释器路径"
let g:ycm_path_to_python_interpreter='/usr/bin/python'
"是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关闭预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项"
let g:ycm_cache_omnifunc=0
"字符串中也开启补全"
let g:ycm_complete_in_strings = 1
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项"
" inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'     
"上下左右键行为"
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'
" ag.vim
nnoremap <leader>/ :Ag!<space>
nmap 8 :Ag! <C-R>=expand("<cword>")<CR><CR>
let g:ag_highlight=1
" 搜索时不是从当前目录，而是从rootdirectory开始搜索
let g:ag_working_path_mode='r'
" unite
" file_rec递归的列出当前目录的文件
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec<cr>
nnoremap <leader>x :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
" 列出当前目录下的文件
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
" nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>/ :Unite grep:.<cr>
let g:unite_source_rec_async_command =
	\ ['ag', '--follow', '--nocolor', '--nogroup', 
    \ '--depth', '10', '--hidden', '-g', '']
	let g:unite_source_rec_min_cache_files = 1200
	let g:unite_source_grep_max_candidates = 200

call unite#custom#source('file', 'ignore_pattern', ".swp,*.o",)

if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " Use pt in unite grep source.
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  " Use ack in unite grep source.
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
  \ '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''
endif

" Custom mappings for the unite buffer
" autocmd FileType unite call s:unite_settings()
" function! s:unite_settings()
  " " Play nice with supertab
  " let b:SuperTabDisabled=1
  " " Enable navigation with control-j and control-k in insert mode
  " imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  " imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
" endfunction

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
		  \ unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
  nmap <buffer> x     <Plug>(unite_quick_match_jump)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
		  \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
	nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
	nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_sorters(
		  \ empty(unite#mappings#get_current_sorters()) ?
		  \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction"}}}

" To be continued
