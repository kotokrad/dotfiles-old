let mapleader =","

" Install VimPlug
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" CoC extensions should be defined before plugin install
  " \ 'coc-pairs',
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-prettier'
  \ ]

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" DISABLED
" Plug 'kovetskiy/sxhkd-vim'
" Plug 'junegunn/goyo.vim'
" Plug 'Yggdroot/indentLine'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'sbdchd/neoformat'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'tpope/vim-fugitive'
" Plug 'Xuyuanp/yanil'

" UI
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'norcalli/nvim-colorizer.lua'

" FUNCTIONAL
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'ptzz/lf.vim'
Plug 'godlygeek/tabular'

" DEV
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() } }
Plug 'windwp/nvim-autopairs'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'TovarishFin/vim-solidity'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim', { 'branch': 'styled' }
Plug 'itchyny/vim-gitbranch'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" MISC
Plug 'vimwiki/vimwiki'

call plug#end()

" Default options
	nnoremap c "_c
	set nocompatible
	syntax on
	set encoding=utf-8
	set number relativenumber
	set tabstop=2 softtabstop=2
	set shiftwidth=2
	set expandtab
	set smartindent
	set hidden
  set updatetime=100
  set noshowmode
  set cursorline
  set go=a
  set mouse=a
  set splitbelow splitright                 " non-retarded splits
  set cmdheight=1                           " only one line for commands
  set shortmess+=c                          " don't need to press enter so often
  set wildmode=longest,list,full            " enable autocompletion
  set completeopt=menuone,noinsert,noselect " better autocomplete options
  set signcolumn=yes                        " add a column for sings (e.g. GitGutter, LSP, ...)
  set termguicolors
  set t_Co=256
  set t_ut=
  filetype plugin indent on                 " enable detection, plugins and indents

" Move lines around
  nnoremap <C-j> :m .+1<CR>==
  nnoremap <C-k> :m .-2<CR>==
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv

" Split navigation/manipulation
  nnoremap <leader>c :Bclose<CR>
  " TODO: split navigation hotkeys
  " map <C-l> <C-w>l
  " map <C-h> <C-w>h

" Buffer cycling
	nnoremap <C-l> :bnext<CR>
	nnoremap <C-h> :bprev<CR>

" Replace word
  nnoremap <leader>p :norm viw"0p<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	" map <leader>o :setlocal spell! spelllang=en_us<CR>

" Replace ex mode with gq
	" map Q gq

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
	vmap S :s//g<Left><Left>

" Map + for easier clipboard access
  nnoremap + "+
  inoremap <C-p> <C-R>"

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" Run Prettier before writing js files
	autocmd BufWritePre *.{js,jsx,ts,tsx} Prettier

" Fix syntax highlighting in long files
" UPD: still needed after switching to treesitter?
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Save session on exit, if one exists
  function! SaveSession()
    if v:this_session != ""
      exe 'mksession! ' . v:this_session
    endif
  endfunction

  autocmd VimLeave * :call SaveSession()
  autocmd BufWritePost * :call SaveSession()

" Markdown fenced languages
  let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'typescript', 'ts=typescript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

" SPECIAL
" (requires some external scripts)
" =================================

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %


" PLUGINS
" =================================

" Goyo plugin makes text more readable when writing prose:
	" map <leader>f :Goyo <CR>
  "\| set bg=light \| set linebreak<CR>

" Airline
  " let g:airline_powerline_fonts = 1
  " let g:airline_theme='solarized_flood'
  " let g:airline_solarized_bg='dark'

" Lightline
  " \ 'colorscheme': 'darcula',
  " \ 'colorscheme': 'solarized',
  " \ 'colorscheme': 'one',
  let g:lightline = {
      \ 'colorscheme': 'codedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ }

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction

" CtrlP
	" let g:ctrlp_map = '<c-p>'
	" let g:ctrlp_cmd = 'CtrlP'
	" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" FZF
  let g:fzf_layout = { 'down': '40%' }
  nnoremap <C-f> :Ag<space>
  nnoremap <C-p> :Files<CR>

" Vimagit
  nnoremap <leader>m :Magit<CR>
  nnoremap ,m :Magit<CR>

" EasyMotion
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature

  " Jump to anywhere you want with minimal keystrokes, with just one key binding.
  " `s{char}{label}`
  nmap s <Plug>(easymotion-overwin-f2)

  " Move to word
  map  ,w <Plug>(easymotion-bd-w)
  nmap ,w <Plug>(easymotion-overwin-w)

" NERDTree
  map <C-b> :NERDTreeToggle<CR>

" CHADTree
  " map <C-b> :CHADopen<CR>
  " nnoremap <leader>l <cmd>call setqflist([])<cr>
  " " let g:chadtree_settings = { "theme.text_colour_set": "solarized_dark_256" }
  " " let g:chadtree_settings = { "theme.text_colour_set": "nerdtree_syntax_dark" }
  " let g:chadtree_settings = {
  "     \ "theme.text_colour_set": "nerdtree_syntax_dark"
  "     \ }

" Yanil
  " DISABLED " silent!
  " lua require("_yanil").setup()
  " nmap <C-b> :YanilToggle<CR>
  " DISABLED " nmap <C-b> :lua require('nvim-web-devicons').setup()<CR> :YanilToggle<CR>

  " augroup dotvim_auto_close_yanil
  "   autocmd!
  "   autocmd BufEnter Yanil if len(nvim_list_wins()) == 1 | q | endif
  "   autocmd FocusGained * silent! lua require('yanil/git').update()
  " augroup end

" Tabularize
  " if exists(":Tabularize") " Doesn't work
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
    nmap <Leader>t<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>t<Bar> :Tabularize /<Bar><CR>
    nmap <Leader>T ggVG:Tabularize /<Bar><CR>G
    vmap <Leader>T :Tabularize /<Bar><CR>
  " endif
  function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" UltiSnips (snippets)
	let g:UltiSnipsExpandTrigger="<C-Space>"
	let g:UltiSnipsJumpForwardTrigger="<C-j>"
	let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" Emmet
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,js EmmetInstall
  "autocmd FileType html,css,js nnoremap <Tab> :call emmet#expandAbbr(3,"")<CR><i>

" CoC plugin (mostly JS/TS)
  command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nnoremap <silent> K :call CocActionAsync('doHover')<cr>

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>a <Plug>(coc-codeaction)
	nmap <C-s> :Prettier<CR>

  " Use cr to confirm completion
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use tab for trigger completion with characters ahead and navigate.
  function! s:check_back_space() abort
    let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" JSX plugin (syntax highlight)
  let g:vim_jsx_pretty_highlight_close_tag = 1
  let g:vim_jsx_pretty_colorful_config = 1

" Tree-Sitter (syntax highlighting, doesn't support JSX yet)
lua <<EOF
  require('nvim-treesitter.configs').setup {
    -- install all maintained languages
    ensure_installed = "maintained",
    -- or list of languages
    -- ensure_installed = { "javascript", "typescript", "bash", "go", "json", "html", "lua", "python", "css" }
    highlight = {
      enable = true,              -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
    },
    -- tree-sitter based indentation
    indent = {
      enable = true
    }
  }
EOF

" Autopairs
  lua require('nvim-autopairs').setup()

" Colorizer
  lua require('colorizer').setup()

" Colorful Devicons
  lua require('nvim-web-devicons').setup()

  augroup dotvim_nvim_devicons
    autocmd!
    autocmd ColorScheme * lua require('nvim-web-devicons').setup()
  augroup end

" VimWiki (notes)
  let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_global_ext = 0
  let g:vimwiki_table_mappings = 0 " Disable Tab in input mode

" Tmux-navigator
  " let g:tmux_navigator_no_mappings = 1
  " nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
  " nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
  " nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
  " nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
  " nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>


" THEME
" =================================
  let g:gruvbox_italic=1
  let g:gruvbox_contrast_dark='hard'
  colorscheme gruvbox
  set background=dark
