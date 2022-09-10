set shell=/bin/bash

" Switch between two buffers very quickly
nnoremap <leader><leader> <c-^>

" Set no compatiblity mode
set nocompatible

" Remap escape
inoremap jk <Esc>

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Some needed settings
set number
set encoding=utf8
set colorcolumn=80 tabstop=4 shiftwidth=4 softtabstop=4
set showcmd
set expandtab
set autoread
set cursorline
set wildmenu
set relativenumber

"Decrease time in which vims stores swap to disk
set updatetime=100

" Sets the clipboard to system clipboard
set clipboard+=unnamedplus

" Turn on syntax highlighting.
syntax on

filetype plugin on

" Disable the default Vim startup message.
set shortmess+=I

" Set Darkmode
set bg=dark

if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
    packadd! matchit
endif

" Always show the status line at the bottom, even if you only have one window
" open.
set laststatus=2

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on t
" is too much, but it can
" sometimes be convenient.
set mouse+=a

" Quick save
noremap <Leader>s :update<CR>

" Open up vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Clear highlighted entries
nnoremap <leader>c :nohl<CR><C-l>

" For python stuff
au BufNewFile,BufRead *.py
    \ set fileformat=unix

" For stupid web dev
au BufNewFile,BufRead *.js,*.html,*.css,*.jsx
    \ setlocal tabstop=2
    \| setlocal softtabstop=2
    \| setlocal shiftwidth=2

" Install Plug if already not installed
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim"/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Install plugins：:PlugInstall
" Update plugins：:PlugUpdate
" Remove plugins：:PlugClean (First, comment the plugin install command
" in init.vim. Open Nvim and use :PlugClean to uninstall plugins)
" Check the plugin status：:PlugStatus
" Upgrade vim-plug itself：:PlugUpgrade

" Gruvbox theme
Plug 'gruvbox-community/gruvbox'

" Dracula theme
Plug 'dracula/vim'
" Airline status bar
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Commenting Plugin
Plug 'tpope/vim-commentary'

" For neovim terminal usage
Plug 'vimlab/split-term.vim'

" Vim surround :)
Plug 'tpope/vim-surround'

" Plugin to allow sudo write
Plug 'lambdalisue/suda.vim'

" Plugin to show vertical indent bar lines
Plug 'Yggdroot/indentLine'

" Syntax highligthing for js files
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Vim Go!!!!
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" VimWiki
Plug 'vimwiki/vimwiki'

" Black integration
Plug 'psf/black', { 'branch': 'stable' }
" Fuzzy search files
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git diff in vim
Plug 'airblade/vim-gitgutter'

" Vim Clang Format
Plug 'rhysd/vim-clang-format'

" Native LSP
Plug 'neovim/nvim-lspconfig'

" Bracket completion
Plug 'jiangmiao/auto-pairs'

"Rainbow brackets
Plug 'frazrepo/vim-rainbow'

"Racket plugin
Plug 'wlangstroth/vim-racket'

" Autocompletion using cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

""Rust plugin
Plug 'rust-lang/rust.vim'
"" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

"" org mode plug
Plug 'jceb/vim-orgmode'

call plug#end()

syntax enable
filetype plugin indent on

""
"" Configure LSP through rust-tools.nvim plugin.
"" rust-tools will configure and enable certain LSP features for us.
"" See https://github.com/simrat39/rust-tools.nvim#configuration
"lua <<EOF
"local nvim_lsp = require'lspconfig'

"local opts = {
"    tools = { -- rust-tools options
"        autoSetHints = true,
"        hover_with_actions = true,
"        inlay_hints = {
"            show_parameter_hints = false,
"            parameter_hints_prefix = "",
"            other_hints_prefix = "",
"        },
"    },
"}

"require('rust-tools').setup(opts)
"EOF


lua << EOF
local nvim_lsp = require('lspconfig')
  -- Setup nvim-cmp.
  local cmp = require'cmp'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
    local opts = { 
        noremap=true, silent=true,
    }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Forward to other plugins
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    -- Installed sources
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
    })
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"pyright", "rust_analyzer"}
for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF


" Colorscheme settings
let t_Co=256
set notermguicolors
" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark='hard'
colorscheme dracula

" Airline settings
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1

" Open vertical terminal on f5
set splitbelow
nnoremap <f5> :50VTerm<CR>

" Open horizontal terminal on f4
set splitright
nnoremap <f4> :15Term<CR>

" Disable indent line on the following files
let g:indentLine_fileTypeExclude = ['json', 'md', 'markdown', 'vimwiki', '.wiki']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']

" Black settings
let g:black_linelength = 80
let g:black_quiet = 1

" Run Black on save
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.rs execute ':RustFmt'

" Run Black on pressing <F3>
nnoremap <F3> :Black<CR>

let g:python3_host_prog="/usr/local/bin/python3"

" Disasble global wiki
let g:vimwiki_global_ext = 0

" Fix vimwiki
let g:indentLine_concealcursor=""
let g:indentLine_conceallevel=2


" Clang format options
nmap <silent> <leader>f :ClangFormat<CR>
vmap <silent> <leader>f :ClangFormat<CR> 
let g:clang_format#code_style="mozilla"

" Keep cursor centered while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" Clang format by default uses 2 spaces to indent
au BufNewFile,BufRead *.cpp
    \ setlocal tabstop=2
    \| setlocal softtabstop=2
    \| setlocal shiftwidth=2

" fzf
nnoremap <silent> <C-f> :Files<CR>

" switching between buffers
noremap <PageDown> :bn<cr>
noremap <PageUp> :bp<cr>
noremap <End> :bd<cr>
