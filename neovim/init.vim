" ===========================================
" Plugin manager (vim-plug)
" ===========================================
call plug#begin('~/.vim/plugged')

" LSP / completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" File tree / icons
Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" Navigation / editing
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'diepm/vim-rest-console'
Plug 'cakebaker/scss-syntax.vim'
Plug 'habamax/vim-godot'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'mbbill/undotree'
Plug 'szw/vim-maximizer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kassio/neoterm'
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" UI / statusline / themes / dashboard / notifications
Plug 'nvim-lualine/lualine.nvim'
Plug 'itchyny/vim-gitbranch'
Plug 'catppuccin/vim', {'as': 'catppuccin'}
Plug 'folke/tokyonight.nvim'
Plug 'goolord/alpha-nvim', {'do': ':UpdateRemotePlugins'}
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

" Copilot (Lua version) + CMP bridge + Chat
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'nvim-lua/plenary.nvim'

" Snippets for JS/React (postinstall build)
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }

" Indentation guides
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()


" ===========================================
" Basic settings
" ===========================================
set number relativenumber
set mouse=a
set nobackup
set nowritebackup
set termguicolors
set background=dark
set cmdheight=1

" Ignore common heavy folders/files in searches
set wildignore=./node_modules/**,./.git/**

let g:NERDTreeIgnore = ['^node_modules$']

" CtrlP ignore rules
let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_custom_ignore = {
      \ 'dir':  'target\|node_modules\|dist',
      \ 'file': '\.class$\|\.ttf\|\.eot\|\.woff\|\.woff2'
      \ }

" Markdown fenced languages (better TS/JS highlighting)
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript']


" ===========================================
" Keymaps
" ===========================================
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F8> :!prettier --single-quote --trailing-comma es5 --print-width 140 --write %<CR>
nnoremap <F7> :!clang-format -i %<CR>
tnoremap <Esc> <C-\><C-n>

" Telescope quick access
nnoremap <F4>f <cmd>Telescope find_files<cr>
nnoremap <F4>g <cmd>Telescope live_grep<cr>
nnoremap <F4>b <cmd>Telescope buffers<cr>
nnoremap <F4>h <cmd>Telescope help_tags<cr>

" Dashboard
nnoremap <silent> <F5>a :tabnew \| Alpha<CR>


" ===========================================
" Tabs vs spaces (quick helpers)
" ===========================================
function! UseTabs()
  " 4-space visual width, insert tabs
  set tabstop=4
  set shiftwidth=4
  set noexpandtab
  set autoindent
endfunction

function! UseSpaces()
  " 2-space indentation, insert spaces
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set softtabstop=0
  set autoindent
  set smarttab
endfunction
call UseSpaces()


" ===========================================
" GUI (Neovide)
" ===========================================
let g:neovide_transparency = 1.0
set guifont=DejaVu\ Sans\ Mono\:h20
let g:neovide_cursor_vfx_mode = "railgun"


" ===========================================
" LSP (TypeScript)
" ===========================================
lua << EOF
local lsp = require('lspconfig')
lsp.ts_ls.setup({})
EOF

" LSP keymaps
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>


" ===========================================
" Colorscheme & Lua entrypoint
" ===========================================
colorscheme tokyonight-storm
" Load additional Lua config (keep it generic)
luafile ~/.config/nvim/lua/init.lua


" ===========================================
" Abbreviations (React/Next hooks and snippets)
" Tip: type the trigger then <Space>/<Enter>
" ===========================================
" React hooks
iabbrev usee- useEffect(() => {<CR>}, [])
iabbrev usec- useContext
iabbrev usest- useState(<CR>)
iabbrev user- useRef(null)
iabbrev usem- useMemo(() => <CR>, [])
iabbrev usecb- useCallback(() => <CR>, [])
iabbrev usel- useLayoutEffect(() => {<CR>}, [])

" Functional component
iabbrev prc- import React from 'react';<CR><CR>const Component = () => {<CR>  return (<CR>    <div></div><CR>  );<CR>};<CR><CR>export default Component;

" Next.js page example (router)
iabbrev prcp- import React from 'react';<CR>import { useRouter } from 'next/router';<CR><CR>const Page = () => {<CR>  const router = useRouter();<CR>  return (<CR>    <div>Page {router.pathname}</div><CR>  );<CR>};<CR><CR>export default Page;

" tRPC client quick snippets
iabbrev trpcimport- import { trpc } from '../utils/trpc';<CR>
iabbrev trpcq- const { data, error } = trpc.example.getData.useQuery();<CR>
iabbrev trpcm- const mutation = trpc.example.createData.useMutation();<CR>

" Next.js API route
iabbrev apiimport- import { NextApiRequest, NextApiResponse } from 'next';<CR>
iabbrev apihandler- export default function handler(req: NextApiRequest, res: NextApiResponse) {<CR>  res.status(200).json({ message: 'Hello from API' });<CR>}

" Generic React component
iabbrev rafc- import React from 'react';<CR><CR>const ReactComponent = () => {<CR>  return (<CR>    <div></div><CR>  );<CR>};<CR><CR>export default ReactComponent;
iabbrev rafcp- import React from 'react';<CR><CR>const ReactComponent = () => {<CR>  return (<CR>    <div></div><CR>  );<CR>};<CR><CR>export default ReactComponent;


" ===========================================
" Shell
" ===========================================
set shell=/usr/bin/zsh


" ===========================================
" Filetype tweaks
" ===========================================
autocmd BufNewFile,BufRead *.script set filetype=lua

