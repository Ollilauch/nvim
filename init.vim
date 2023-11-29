" numbers
 :set number
 :set relativenumber

" text wrapping
 :set nowrap

" Wrap Text in org and tex files
 augroup WrapLineInTeXFile
     autocmd!
     autocmd FileType tex, org setlocal wrap
 augroup END

" indent
 :set autoindent
 :set tabstop=4
 :set shiftwidth=0
 :set expandtab

" Use ctrl-[hjkl] to select the active split!
 nmap <silent> <c-k> :wincmd k<CR>
 nmap <silent> <c-j> :wincmd j<CR>
 nmap <silent> <c-h> :wincmd h<CR>
 nmap <silent> <c-l> :wincmd l<CR>
" Use ctrl-[left,up,down,right] to selecte split
 nmap <silent> <c-Up>       :wincmd k<CR>
 nmap <silent> <c-Down>     :wincmd j<CR>
 nmap <silent> <c-Left>     :wincmd h<CR>
 nmap <silent> <c-Right>    :wincmd l<CR>

" source file of vim-plug
 source $HOME/.config/nvim/vim-plug/plugins.vim

" colorcheme
 colorscheme catppuccin-mocha


" lua config
lua << EOF
    require('nvim-treesitter.configs').setup{ensure_installed = "c", "zig", "cpp", "ts", "python", "org", auto_install = true, highlight = { enable = true, additional_vim_regex_highlighting = {'org'} }, indent = { enable = true}}
    require('nvim-autopairs').setup{} 
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    npairs.add_rules({
    Rule("$", "$", "tex")
     :with_move(function(opts)
         return opts.next_char == opts.char
         end)
    })


    require('orgmode').setup_ts_grammar()
    require('orgmode').setup({
         org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
         org_default_notes_file = '~/notes/refile.org',
         org_hilight_latex_and_related = "entities",
         emacs_config = { executable_path = 'emacs', config_path='$HOME/.config/emacs/init.el' }
    })
    require'sniprun'.setup({
    interpreter_options = {
        C_original = {
             compiler = "gcc"
            }
        }
    })
    require('neorg').setup {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/notes/norg",
                    },
                    default_workspace = "notes",
                },
            },
        },
    }
    require('org-bullets').setup()
    require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
    require("luasnip").config.set_config({
      -- Setting LuaSnip config
      -- Enable autotriggered snippets
      enable_autosnippets = true,
      -- Use Tab (or some other key if you prefer) to trigger visual selection
      store_selection_keys = "<Tab>",
    })

    -- nvim-cmp setup
    local cmp = require 'cmp'

    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Add nvim-lspconfig plugin
    local lspconfig = require 'lspconfig'
    
    -- Enable the following language servers
    local servers = { 'ccls', 'rust_analyzer', 'pyright', 'tsserver', 'ltex' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
        ltex = {
              -- language = "en"
              language = "de-DE"
            }
          },
        root_dir = function(fname)   
            return vim.loop.cwd()
        end,
        lsp = {use_defaults = true},
      }
    end

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<C-z>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set({ 'n' }, '<Leader>k', function()
            vim.lsp.buf.signature_help()
        end, { silent = true, noremap = true, desc = 'toggle signature' })
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    lspconfig.lua_ls.setup({})
    
    
    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.5  -- You can change this too

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        relativenumber = true,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                             - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
            end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })

    -- Toggle nvim-tree
    vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>')

    -- Enable Ranger-Nvim
    local ranger_nvim = require("ranger-nvim")
    ranger_nvim.setup({
        replace_netrw = true,
        keybinds = {
        ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
        ["oh"] = ranger_nvim.OPEN_MODE.split,
        ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
        ["or"] = ranger_nvim.OPEN_MODE.rifle,
        },
    })

    -- Change the border's color
    vim.g.rnvimr_border_attr = {fg = 200, bg = -1}
    -- Make Ranger to be hidden after picking a file
    vim.g.rnvimr_enable_picker = true
    vim.keymap.set('n', '<leader>ef', ':RnvirmrToggle<CR>')
    vim.keymap.set('n', '<leader>ef', '<C-\\><C-n>:RnvimrToggle<CR>')

    local example_setup = {
      on_attach = function(client, bufnr)
        require "lsp_signature".on_attach({
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          handler_opts = {
            border = "rounded"
          }
        }, bufnr)
      end,
    }

    require "lsp_signature".setup(example_setup)

    -----------------------------------------
    -- <8>  Spell checking
    -----------------------------------------
    -- Toggle spell checking.
    vim.keymap.set("n", "<leader>sc", ":setlocal spell! spelllang=de<CR>")
EOF

" markdown to latex "
" Specify a Latex Engine from the supported list above
let g:papyrus_latex_engine = 'pdflatex'

" Specify any built-in pdf viewing option. It's recommended to use 
" a pdf viewer with automatic updates on save.
let g:papyrus_viewer = 'zathura'

" Recommended keybinding for compiling and viewing documents
" Adding optional formattings is also possible by 
map <leader>pc :PapyrusCompile<CR>
map <leader>pa :PapyrusAutoCompile<CR>
map <leader>pv :PapyrusView<CR>
map <leader>ps :PapyrusStart<CR>

" LATEX config
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
 filetype plugin on

 syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
 let g:vimtex_view_method = 'zathura'

 let g:vimtex_compiler_method = 'latexmk'

 function! InstallPackages()
    let winview = winsaveview()
    call inputsave()
    let cmd = ['sudo -S tlmgr install']
    %call add(cmd, matchstr(getline('.'), '\\usepackage\(\[.*\]\)\?{\zs.*\ze\}'))
    echomsg join(cmd)
    let pass = inputsecret('Enter sudo password:') . "\n"
    echo system(join(cmd), pass)
    call inputrestore()
    call winrestview(winview)
endfunction

command! InstallPackages call InstallPackages()


" LuaSnip Config
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
" inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
" 
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>


