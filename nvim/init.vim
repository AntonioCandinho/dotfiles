" Enable syntax coloring
" syntax on

" Hybrid line number
:set number relativenumber

" Map leader to ,
:let mapleader=","

" Inentation settings (2 spaces by default)
set tabstop=2 " show tab as 2 spaces 
set shiftwidth=2 " intend in visual mode uses 2 spaces
set expandtab " on presing tab insert 2 spaces

" For C files (Kernel style)
" autocmd FileType c,h setlocal ts=8 sw=8 expandtab
" autocmd FileType c,cc,cpp,h,hh,hpp ClangFormatAutoEnable

" Not jump out of visual mode on tab
vnoremap < <gv 
vnoremap > >gv

" Persistent undo and backups
set backup
set backupdir   =/Users/antonio/.config/nvim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =/Users/antonio/.config/nvim/files/swap/
set updatecount =100
set undofile
set undodir     =/Users/antonio/.config/nvim/files/undo/
set viminfo     ='100,n/Users/antonio/.config/nvim/files/info/viminfo

" Filename completion
set wildmode=longest,list,full
set wildmenu

" Habit making, habit breaking
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>
noremap h <NOP>
noremap l <NOP>

" Change buffer without saving 
set hidden

" Build markdown composer
" function! BuildComposer(info)
"   if a:info.status != 'unchanged' || a:info.force
"     if has('nvim')
"       !cargo build --release
"     else
"       !cargo build --release --no-default-features --features json-rpc
"     endif
"   endif
" endfunction
 
" Plugin configuration
call plug#begin()

" Markdown preview (UML support)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Fuzy finder (Crtl + P)
Plug 'junegunn/fzf'

" Live markdown preview
" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Vim tmux config
Plug 'christoomey/vim-tmux-navigator'

" Auto detects and tryes to respect indent
Plug 'ciaranm/detectindent'

" FuGitve
Plug 'tpope/vim-fugitive'

" Disable repetition of hjkl && arrows
Plug 'takac/vim-hardtime'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Automatically adds closing ' " { 
" Plug 'jiangmiao/auto-pairs'

" Autoclose html
Plug 'alvan/vim-closetag'

" Autocompletion supertab
" Plug 'ervandew/supertab'

" Autocompletion
" Plug 'maralla/completor.vim' -- With large files freezes really bad
" Plug 'Rip-Rip/clang_complete' -- Can not find how it works
" function! BuildYCM(info)
"   " info is a dictionary with 3 fields
"   " - name:   name of the plugin
"   " - status: 'installed', 'updated', or 'unchanged'
"   " - force:  set on PlugInstall! or PlugUpdate!
"   if a:info.status == 'installed' || a:info.force
"     !./install.py --all
"   endif
" endfunction

" YouCompleteMe (C++ and Js completions)
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" CoC
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Linting
" Plug 'w0rp/ale'

" Powerline 
Plug 'vim-airline/vim-airline'
" Plug 'itchyny/lightline.vim'
" Snippets support
" Plug 'SirVer/ultisnips'

" C++ syntax coloring
" Plug 'octol/vim-cpp-enhanced-highlight'

" Arduino support
" Plug 'stevearc/vim-arduino'

" Buffer kill that maintains windows intact
Plug 'qpkorr/vim-bufkill'

" ReasonML syntax support
Plug 'reasonml-editor/vim-reason-plus'

" ASM support
Plug 'alisdair/vim-armasm'

" Clang format
Plug 'rhysd/vim-clang-format'

" DirDiff
Plug 'will133/vim-dirdiff'

" Rust support
Plug 'rust-lang/rust.vim'

" Native NVIM LSP
Plug 'neovim/nvim-lspconfig'

" Fast completion using COQ
" Plug 'ms-jpq/coq_nvim', { 'do': 'COQdeps' }

" Completion Over LSP CMP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" OLD SYNTAX HIGHLIGTHNING
" -------------------------

" JSX support
" Plug 'mxw/vim-jsx'
" 
" " Javascript es7 syntax
" Plug 'othree/yajs.vim'
" 
" " Support for TS syntax
" Plug 'HerringtonDarkholme/yats.vim'
" 
" " Improved Js syntex
" Plug 'pangloss/vim-javascript'
" 
" " UML syntax
" Plug 'aklt/plantuml-syntax'
" 
" " Support for haskell syntax
" Plug 'neovimhaskell/haskell-vim'
" 
" " Typescript syntax
" Plug 'leafgarland/typescript-vim'
" 
" Swift syntax
Plug 'keith/swift.vim'

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Syntax highlighting with treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Prettier support
Plug 'prettier/vim-prettier'
 
call plug#end()

" Editor config
set exrc
set secure

" Fuzzy finder map
nnoremap <C-p> :FZF<CR>

" Nerd tree
let NERDTreeIgnore = ['\.pyc$', '\.o', '^moc_']
map <C-n> :NERDTreeToggle<CR>

" Make supertab go top to bottom
let g:SuperTabDefaultCompletionType = "<c-n>"

" Configure .clang_format
let g:clang_format#detect_style_file = 1
" let g:clang_format#command = "/usr/lib64/llvm/8/bin/clang-format"

" Configuration for YouCompleteMe
"let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'
"nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Powerline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ala#enabled = 1

" Change to gruvbox color scheme
let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_style='medium'
set background=dark
set termguicolors
let g:airline_theme='gruvbox'
colorscheme gruvbox

" Latex previewer
let g:livepreview_previewer = 'evince'

" Ale options
" Change eslint to eslint_d -> faster
" let g:ale_javascript_eslint_executable = 'eslint_d'

" Ale arm asm
" let g:ale_asm_gcc_executable = 'arm-none-eabi-gcc'

" Ale reason ml
" let g:ale_reason_ols_use_global = 1

" Ale clang_complete
" Disable some linters
" let g:airline#extensions#ale#enabled = 1
" let g:ale_linters = { 'cpp': [ 'clang', 'clangtidy'], 'c': [ 'clang', 'clang-format', 'gcc' ], 'javascript': [ 'eslint' ], 'typescript': ['eslint', 'tslint'] }

" Read clang complete
function! FindFile(file_name)
  let current_dir = getcwd() . "/"
  while strlen(current_dir)
    let full_file_name = current_dir . a:file_name
    if filereadable(full_file_name)
      return full_file_name
    endif
    let current_dir = strpart(current_dir, 0, strlen(current_dir) - 1)
    let current_dir = strpart(current_dir, 0, strridx(current_dir, "/") + 1)
  endwhile
  return ""
endfunction

" Ale try to use compilation db
" let g:ale_c_parse_compile_commands = 1 
" let g:ale_c_build_dir_names = [ '', 'build', 'build/amd', 'build/arm' ]

" let clang_complete = FindFile(".clang_complete")
" if strlen(clang_complete)
"     let clang_options = join(readfile(clang_complete), " ")
"     let g:ale_cpp_clang_options = clang_options
"     let g:ale_c_clang_options = clang_options
"     let g:ale_cpp_gcc_options = clang_options
"     let g:ale_c_gcc_options = clang_options
"     let g:ale_asm_gcc_options = clang_options
"     let current_dir = ""
" endif
"
"
" Merlin (Reason + Ocaml)
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Spelling support
set spell spelllang=en_us

" Enable modeline
set modeline
set modelines=5

" Backup copy
set backupcopy=yes

" Treat mjs files as javascript
autocmd BufRead,BufNewFile *.mjs :setlocal filetype=javascript

" Dirdiff ignore
let g:DirDiffExcludes = ".svn,.git,.hg,*.swp"

" Enable save as root on :Sw
command! -nargs=0 Sw w !sudo -S tee % > /dev/null

" Enable hardtime
let g:hardtime_default_on = 1

" Disable YCM for Js completion
"let g:ycm_global_ycm_extra_conf = { 'javascript.jsx': 1, 'javascript': 1 }

"" Configure CoC with airline
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
 
"" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Map Ctrl-C to Esc to do autocmds 
ino <C-C> <Esc>

" Map leader to space
let mapleader = " "

" FUZZY FIND CONFIG
nnoremap <silent> <leader><Space> :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>

"coc keymappings
" nmap <leader>rw <Plug>(coc-rename)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>cf <Plug>(coc-fix-current)

" Require NVIM LSP Lua 
lua require("lsp-config") 

" Configure prettier formatting
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat_require_pragma = 0

" Enable COQ
" COQnow -s

" NVIM CMP Options
set completeopt=menu,menuone,noselect
