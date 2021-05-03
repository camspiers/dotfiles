-- local helpers
local any = require'plenary.functional'.any
local is = function(a) return function(_, b) return a == b end end

-- formatter start
local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end
local function luaformat()
  return {
    exe = "lua-format",
    args = {"--indent-width", 2, "--tab-width", 2},
    stdin = true
  }
end
require'formatter'.setup {
  filetype = {
    typescriptreact = {prettier},
    typescript = {prettier},
    lua = {luaformat}
  }
}
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.tsx,*.lua FormatWrite
augroup END
]], true)
-- formatter end

-- lualine start
require'lualine'.setup {
  sections = {
    lualine_a = {{'mode', format = function(n) return n:sub(1, 1) end}}
  },
  options = {
    theme = 'tokyonight',
    section_separators = '',
    component_separators = ''
  }
}
-- lualine end

-- compe start
require'compe'.setup {
  autocomplete = true,
  min_length = 1,
  preselect = 'enable',
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    treesitter = true,
    tags = false
  }
}
-- compe end

-- lsp start
-- defines which servers should be set up automatically
local auto_setup_servers = {'bash', 'json', 'tailwindcss', 'html'}

local function setup_servers()
  -- setup lspinstall, makes configs available for lspconfig
  require'lspinstall'.setup()

  -- used for calling setup
  local config = require 'lspconfig'

  -- get the installed servers
  local servers = require'lspinstall'.installed_servers()

  -- helper to check if server is installed
  local server_installed = function(server) return any(is(server), servers) end

  -- for each installed server which has auto setup requested
  for _, server in pairs(auto_setup_servers) do
    if server_installed(server) then config[server].setup {} end
  end

  -- manual setup for lua
  if server_installed('lua') then
    config.lua.setup {
      settings = {
        Lua = {
          runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
          diagnostics = {globals = {'vim'}},
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
            }
          }
        }
      }
    }
  end

  -- manual setup for typescript
  if server_installed('typescript') then
    config.typescript.setup {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false

        -- setup ts-utils
        local utils = require 'nvim-lsp-ts-utils'
        utils.setup {disable_commands = true, enable_formatting = false}
        require'which-key'.register({
          ["<leader>go"] = {utils.organize_imports, "LSP Organize"},
          ["<leader>gr"] = {utils.rename_file, "LSP Rename File"},
          ["<leader>gi"] = {utils.import_all, "LSP Import All"},
          ["<leader>gc"] = {utils.fix_current, "LSP Fix Current"}
        }, {buffer = bufnr})
      end,
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = true,
              signs = true,
              underline = true,
              update_in_insert = true
            })
      }
    }
  end

  if server_installed('csharp') then config.csharp.setup {} end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

local actions = require 'telescope.actions'
local telescope = require 'telescope'
telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
      '--column', '--smart-case', '--hidden', "--iglob", "!.DS_Store",
      "--iglob", "!.git"
    },
    mappings = {i = {["<esc>"] = actions.close}}
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}

telescope.load_extension 'fzf'
telescope.load_extension 'tmuxinator'

require'nvim-ts-autotag'.setup()
require"toggleterm".setup {}
require"gitsigns".setup()
require'nvim_comment'.setup {create_mappings = false}

-- temporary diable virtual text because of background color weirdness
require'lspsaga'.init_lsp_saga {
  -- code_action_prompt = {enable = true, virtual_text = false}
}

vim.fn.sign_define("LspDiagnosticsSignError", {
  texthl = "LspDiagnosticsSignError",
  text = "",
  numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
  texthl = "LspDiagnosticsSignWarning",
  text = "",
  numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
  texthl = "LspDiagnosticsSignHint",
  text = "",
  numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
  texthl = "LspDiagnosticsSignInformation",
  text = "",
  numhl = "LspDiagnosticsSignInformation"
})

require'which-key'.setup {
  window = {border = "single"},
  layout = {height = {min = 100}} -- encourage a single column
}
