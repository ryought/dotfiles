" vimrc
"  - ryought

" ============= PLUGINS ===================
" Install plug.vim if necessary
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  "------ essentials --------------
  " fzf
  " if has('mac')
  "   Plug '/usr/local/opt/fzf'
  " else
  "   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " endif
  " Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " snippet engine
  if has('python3')
    Plug 'SirVer/ultisnips'
  elseif has('python')
    Plug 'SirVer/ultisnips', {
          \   'tag': '3.2',
          \   'dir': get(g:, 'plug_home', '~/.vim/bundle') . '/ultisnips_py2',
          \ }
  endif

  " extend commands
  Plug 'tpope/vim-commentary'  " gc commentize
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tmhedberg/matchit'  " html tag % matching
  Plug 'tpope/vim-surround'  " surrounding pattern
  Plug 'junegunn/vim-easy-align'  " align
  " enhance visual
  Plug 'luochen1990/rainbow'  " rainbow parenthes
  Plug 'Yggdroot/indentLine'
  " color-scheme
  Plug 'morhetz/gruvbox'

  "------ git --------------
  Plug 'tpope/vim-fugitive'  " git plugin
  Plug 'airblade/vim-gitgutter'
  Plug 'editorconfig/editorconfig-vim'  " editorconfig

  "------ Language Server Protocol -----
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  "------ language --------------
  " go
  Plug 'vim-jp/vim-go-extra' , { 'for': 'go' }
  " markdown
  Plug 'plasticboy/vim-markdown'
  " js, ts, jsx (https://github.com/MaxMEllon/vim-jsx-pretty)
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  " vue
  Plug 'posva/vim-vue', { 'for': 'vue' }
  Plug 'digitaltoad/vim-pug'
  " json
  Plug 'elzr/vim-json'
  " python
  Plug 'Vimjas/vim-python-pep8-indent'
  " haskell
  Plug 'dag/vim2hs'
  " rust
  Plug 'rust-lang/rust.vim'
  " singularity
  Plug 'singularityware/singularity.lang', {'rtp': 'vim/'}
  call plug#end()
endif

" ============= SETTINGS ==================
" 必須系
filetype plugin indent on  "filetype, plugin, indentを有効化
syntax enable
set nocompatible
set fenc=utf-8  "文字コードをUFT-8に設定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set autoread  " 編集中のファイルが変更されたら自動で読み直す
set hidden "バッファが編集中でも他のファイルを開けるように
set showcmd "入力中のコマンドをステータスに表示
set backspace=indent,eol,start
set ttyfast " fast drawing

 "disable creating backup, swap files
set nobackup  "バックアップ
set noswapfile "スワップ
set viminfo+=n~/.vim/viminfo

" enable persistent-undo feature
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

"""" Appearances
set ruler  " カーソル何行目何列目にあるか表示
set cursorline  " カーソル位置表示 重いのでoff
" set relativenumber
" nnoremap j gj
" nnoremap k gk
set virtualedit=onemore
set showmatch "対応する括弧の強調
set laststatus=2
set wildmenu wildmode=list:longest
set whichwrap=h,l " 行頭行末の移動で前後の行に飛ばないようにする
set background=dark
try
  set background=dark
  colorscheme gruvbox

catch /^Vim\%((\a\+)\)\=:E185/
endtry


if v:version < 800
endif

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
" show tabs
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

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

"""" Mouse
" set mouse=a
" set ttymouse=xterm2

"""" Key Mapping
let mapleader = "\<Space>"
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>t :r !tmux save-buffer -<CR>
" replace it to `C-o:r !tmux save-buffer -<CR>`
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
" remove search highlight
nmap <ESC><ESC> :noh<CR>
" for iPad
noremap! ¥ \
nmap <Leader>^ <C-^>

" 前回のカーソル位置を記憶
" autocmd BufWinLeave ?* silent mkview
" autocmd BufWinEnter ?* silent loadview
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" ============= PLUGIN CONFIGS ============
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]
nnoremap <Leader>e :UltiSnipsEdit<CR>

" easy-align: add operator `ga`
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" fzf.vim
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
let g:fzf_layout = { 'down': '40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>r :Rg<Space>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>F :Files<CR>
nnoremap <Leader>c :Commits<CR>
nnoremap <Leader>C :BCommits<CR>
nnoremap <Leader>m :History<CR>


" indent line
let g:indentLine_char_list = ['|', '¦']


" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
      \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \ 'separately': {
      \   'html': 'default',
      \   '*': 0
      \ }
      \}


" vim-lsp
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> <C-k> <Plug>(lsp-previous-diagnostic)
  nmap <buffer> <C-j> <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" language settings
let g:lsp_settings = {
      \   'pyls-all': {
      \     'workspace_config': {
      \       'pyls': {
      \         'plugins': {
      \           'pyflakes': { 'enabled': v:true },
      \           'flake8': { 'enabled': v:false },
      \           'pycodestyle': { 'enabled': v:false },
      \           'pydocstyle': { 'enabled': v:false },
      \           'jedi_definition': {
      \             'follow_imports': v:true,
      \             'follow_builtin_imports': v:true,
      \           },
      \         },
      \       }
      \     }
      \   },
      \}
let g:lsp_settings_filetype_javascript = 'eslint-language-server'

" show warning text when hovering cursor
let g:lsp_diagnostics_echo_cursor = 1
" style of diagnotics
let g:lsp_diagnostics_signs_error = {'text': 'x'}
let g:lsp_diagnostics_signs_warning = {'text': '>'}
let g:lsp_diagnostics_signs_hint = {'text': '>'}
let g:lsp_diagnostics_highlights_enabled = 0
" disable suggestions
let g:lsp_settings_enable_suggestions = 0
" lsp hover highlight style
highlight lspReference cterm=bold ctermfg=14


" === language specific ===================
" { completion
inoremap {<CR> {<CR>}<C-o>O

" C

" Json
let g:vim_json_syntax_conceal = 0

" markdown tex
let g:vim_markdown_conceal = 0
let g:tex_conceal = 0
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1
autocmd BufNewFile,BufRead *.md setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" javascript

" typescript
" autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript


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

" go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" let g:go_highlight_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1

" haskell
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>t: :Tabularize colon<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <Leader>t= :Tabularize haskell_bindings<CR>

" typescript
autocmd BufRead,BufNewFile *.ts set filetype=typescript

" ros
autocmd BufRead,BufNewFile *.launch set filetype=xml

" vue .vueが崩れる時用
" autocmd FileType vue syntax sync fromstart

" lisp
let g:lisp_rainbow = 1

