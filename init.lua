vim.cmd([[set nocompatible          
set showmatch             
set ignorecase            
set mouse=v               
set hlsearch              
set tabstop=4             
set shiftwidth=4          
set autoindent            
set number relativenumber 
set wildmode=longest,list 
filetype plugin indent on 
syntax on                 
set mouse=a               
set clipboard=unnamedplus 
filetype plugin on
set cursorline            
set ttyfast               
set spell
    :tnoremap <A-h> <C-\><C-N><C-w>h
    :tnoremap <A-j> <C-\><C-N><C-w>j
    :tnoremap <A-k> <C-\><C-N><C-w>k
    :tnoremap <A-l> <C-\><C-N><C-w>l
    :inoremap <A-h> <C-\><C-N><C-w>h
    :inoremap <A-j> <C-\><C-N><C-w>j
    :inoremap <A-k> <C-\><C-N><C-w>k
    :inoremap <A-l> <C-\><C-N><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
	nnoremap <A-2> :split<CR>
	nnoremap <A-3> :vsplit<CR>
	nnoremap <A-t> :terminal<CR>
	augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber nospell
    " allows you to use Ctrl-c on terminal window
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
call plug#begin()
	Plug 'kyazdani42/nvim-web-devicons' " for file icons
	Plug 'kyazdani42/nvim-tree.lua'
		nnoremap <C-n> :NvimTree<CR>
		nnoremap <C-t> :NvimTreeToggle<CR>
	Plug 'Mofiqul/dracula.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'windwp/nvim-autopairs'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
"	Plug 'glepnir/dashboard-nvim'
"		let g:dashboard_default_executive ='telescope'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'akinsho/bufferline.nvim'
	Plug 'nvim-orgmode/orgmode'
	Plug 'lervag/vimtex'
	" This is necessary for VimTeX to load properly. The "indent" is optional.
	" Note that most plugin managers will do this automatically.
	filetype plugin indent on
	
	" This enables Vim's and neovim's syntax-related features. Without this, some
	" VimTeX features will not work (see ":help vimtex-requirements" for more
	" info).
	syntax enable
	
	" Viewer options: One may configure the viewer either by specifying a built-in
	" viewer method:
	let g:vimtex_view_method = 'zathura'
	
	" VimTeX uses latexmk as the default compiler backend. If you use it, which is
	" strongly recommended, you probably don't need to configure anything. If you
	" want another compiler backend, you can change it as follows. The list of
	" supported backends and further explanation is provided in the documentation,
	" see ":help vimtex-compiler".
	let g:vimtex_compiler_method = 'latexmk'
	
	call plug#end()

nnoremap <A-f> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <A-g> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <A-b> <cmd>lua require('telescope.builtin').buffers()<cr>
colorscheme dracula]])
--	Plug 'neoclide/coc.nvim', {'branch': 'release'}
--function! s:check_back_space() abort
--  let col = col('.') - 1
--  return !col || getline('.')[col - 1]  =~ '\s'
--endfunction
--
--inoremap <silent><expr> <Tab>
--      \ pumvisible() ? "\<C-n>" :
--      \ <SID>check_back_space() ? "\<Tab>" :
--      \ coc#refresh()
  -- Setup nvim-cmp.
  local cmp = require'cmp'

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
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
      { name = 'buffer' },
    })
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

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require'lspconfig'.csharp_ls.setup {}
  require'lspconfig'.bashls.setup {}
  require('nvim-autopairs').setup{}
  require("telescope").setup{
	  pickers = {
		  find_files = {
			  hidden = true
		  }
	  }
  }
  require'nvim-tree'.setup {}
  require('lualine').setup()
  require("bufferline").setup{}
-- init.lua

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})
