" vimrc
"  - ryought
" ============= PATH ======================
" path setting
if has('mac')
  let $PATH = "~/.pyenv/shims:".$PATH
endif

" ============= PLUGINS ===================
" package manager: plug.vim
"  to install, run below
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'  " fuzzy file finder
Plug 'lokikl/vim-ctrlp-ag'
Plug 'mileszs/ack.vim'
Plug 'SirVer/ultisnips'  " snippet
Plug 'tpope/vim-commentary'  " gc commentize
Plug 'ntpeters/vim-better-whitespace'
Plug 'tmhedberg/matchit'  " html tag % matching
Plug 'tpope/vim-surround'  " surrounding pattern
Plug 'morhetz/gruvbox' "color-scheme
" go
Plug 'vim-jp/vim-go-extra' , { 'for': 'go' }
Plug 'fatih/vim-go' , { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'godlygeek/tabular'  " align text `:Tab /=`
Plug 'plasticboy/vim-markdown'
" js, ts
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['vue', 'jsx'] }
Plug 'leafgarland/typescript-vim'  " typescript syntax highlighting
Plug 'Quramy/tsuquyomi'  " typescript IDE, client of TSServer

Plug 'davidhalter/jedi-vim'  " python completion こっちの方が良さげ
Plug 'dag/vim2hs'  " haskell
Plug 'tpope/vim-fugitive'  " git plugin
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'  " editorconfig
Plug 'rust-lang/rust.vim'  " rust
Plug 'JuliaEditorSupport/julia-vim' " julia
if has('mac')
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
call plug#end()

" ============= SETTINGS ==================
" 必須系
filetype plugin indent on  "filetype, plugin, indentを有効化
syntax enable
set nocompatible
set fenc=utf-8  "文字コードをUFT-8に設定
set autoread  " 編集中のファイルが変更されたら自動で読み直す
set hidden "バッファが編集中でも他のファイルを開けるように
set showcmd "入力中のコマンドをステータスに表示
set backspace=indent,eol,start

 "disable creating backup, swap files
set nobackup  "バックアップ
set noswapfile "スワップ
set viminfo+=n~/.vim/viminfo

"""" Appearances
set ruler  " カーソル何行目何列目にあるか表示
" set cursorline  " カーソル位置表示 重いのでoff
" nnoremap j gj
" nnoremap k gk
set virtualedit=onemore
set showmatch "対応する括弧の強調
set laststatus=2
set wildmenu wildmode=list:longest
set whichwrap=h,l " 行頭行末の移動で前後の行に飛ばないようにする
set background=dark
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  
endtry

 "ベルを無効化
set noerrorbells 
set novisualbell
set t_vb=

"""" Indent
set expandtab  " use spaces instead of tabs
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

"""" Folding
set nofoldenable  " disable all folding

"""" Search
set ignorecase
set smartcase  "小文字で入れた時は大文字小文字区別しない
set incsearch  " インクリメンタル検索
set hlsearch  "結果をハイライト

"""" Completion
set completeopt=menuone,preview  " 候補が一つでも表示，プレビューウィンドウ使う
set infercase  " 補完時に大文字小文字を無視(set ignorecaseに依存)
set previewheight=6  " preview windowの最大高さ

"""" Key Mapping
let mapleader = "\<Space>"
" viminfoを保存、共有する
nnoremap <Leader>w :wv<CR>
nnoremap <Leader>r :rv!<CR>
" register一覧を表示
nmap <Leader>l :reg<CR>
" mark一覧を表示
nmap <Leader>m :marks<CR>
" コピー
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
" 全文コピー
nmap <Leader>Y gg"+yG
" ペースト
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" 前回のカーソル位置を記憶
" autocmd BufWinLeave ?* silent mkview
" autocmd BufWinEnter ?* silent loadview
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" ============= PLUGIN CONFIGS ============
" ctrlp.vim
let g:ctrlp_map = '<c-p>'
" 最大ファイル数、最大検索深さ
let g:ctrlp_max_files = 100000
let g:ctrlp_max_depth = 10
" vimのカレントディレクトリからのパネル優先
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_new_file = 'r'
" 除外ファイル
set wildignore+=*/tmp/*,*.so,*.swp,*.zip "ファイルを無視
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_extensions = ['quickfix', 'dir', 'line', 'change', 'undo']
" ag or git lsを使って検索
" http://postd.cc/how-to-boost-your-vim-productivity/
let g:ctrlp_use_caching = 0
if executable('ag')
  " use ag if available
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  " use git ls
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" migemo 日本語のfuzzy検索
let g:ctrlp_use_migemo = 1


" ack.vim
" from ag.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
" cnoreabbrev ag Ack
" cnoreabbrev aG Ack
" cnoreabbrev Ag Ack
" cnoreabbrev AG Ack


" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]
nnoremap <Leader>e :UltiSnipsEdit<CR>

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" fzf.vim
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>a :Ag<CR>
nnoremap <Leader>c :Commits<CR>
nnoremap <Leader>C :BCommits<CR>

" gitgutter
" https://github.com/statico/dotfiles/blob/master/.vim/vimrc
nmap \g :GitGutterToggle<CR>
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" === language specific ===================
" { completion
inoremap {<CR> {<CR>}<C-o>O

" C

" markdown tex
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
autocmd BufNewFile,BufRead *.md setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" javascript
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

" typescript
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
let g:tsuquyomi_disable_default_mappings = 1
" show type hint
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" goto def
autocmd FileType typescript nmap gd <Plug>(TsuquyomiDefinition)
" usage
autocmd FileType typescript nmap <Leader>u <Plug>(TsuquyomiReferences)


" tex
"let g:tex_conceal='adsmg'
set conceallevel=0

" html
" omnifunc有効化
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" 閉じたぐ補完
autocmd Filetype html inoremap </ </<C-X><C-O>
autocmd Filetype html inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
" cssとjsが混在しているファイル用
autocmd FileType html syntax sync fromstart

" python
" comment indenting
inoremap # X<c-h>#
" indent
autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4
" python-mode (plugin) setting
" let g:pymode = 1
" let g:pymode_python = 'python3'
" let g:pymode_options = 1
" let g:pymode_folding = 0
" let g:pymode_rope_completion = 1
" let g:pymode_rope_goto_definition_bind = "<leader>d"
" let g:pymode_run_bind = "<leader>r"
" let g:pymode_virtualenv = 1
let g:pymode_rope = 0  "disable

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" syntax checking 重いのできってある
let g:syntastic_python_checkers = ["pyflakes"]
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" haskell
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>t: :Tabularize colon<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>t= :Tabularize haskell_bindings<CR>

" typescript
autocmd BufRead,BufNewFile *.ts set filetype=typescript

" ros
autocmd BufRead,BufNewFile *.launch set filetype=xml

" vue .vueが崩れる時用
autocmd FileType vue syntax sync fromstart

