local whichkey = require 'which-key'
local telescope = require 'telescope'
local telescope_builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'
local hover = require 'lspsaga.hover'
local code_action = require 'lspsaga.codeaction'
local diagnostic = require 'lspsaga.diagnostic'
local lsp_buf = vim.lsp.buf
local buf_key = vim.api.nvim_buf_set_keymap

-- curry helper
local function cmd(c) return function() vim.cmd(c) end end

local lazygit = require"toggleterm.terminal".Terminal:new{
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {border = "curved"},
  on_open = function(term)
    vim.cmd("startinsert!")
    buf_key(term.bufnr, 't', "q", "<Cmd>close<CR>",
            {noremap = true, silent = true})
  end
}

local function projects()
  telescope.extensions.tmuxinator.projects(themes.get_dropdown({}))
end
local function lazygit_toggle() lazygit:toggle() end
local function find_files()
  telescope_builtin.find_files {
    find_command = {
      "rg", "--files", "--hidden", "--iglob", "!.DS_Store", "--iglob", "!.git"
    }
  }
end

whichkey.register {
  -- buffer mangement
  ["<Tab>"] = {cmd('bn'), "Buffer Next"},
  ["<S-Tab>"] = {cmd('bp'), "Buffer Previous"},
  ["<leader>x"] = {cmd('bd'), "Buffer Delete"},
  ["<leader><S-x>"] = {cmd('bd!'), "Buffer Delete (!)"},
  ["<leader>z"] = {cmd('%bd'), "Buffer Delete All"},
  ["<leader><S-z>"] = {cmd('%bd!'), "Buffer Delete All (!)"},
  ["<leader>c"] = {cmd('clo'), "Close"},
  ["<leader><S-c>"] = {cmd('%clo'), "Close All"},

  -- write
  ["<leader>w"] = {cmd('w'), "Write"},

  -- layout
  ["<leader>|"] = {cmd('vs'), "Split Vertical"},
  ["<leader>-"] = {cmd('sp'), "Split Horizontal"},
  ["<leader>o"] = {cmd('on'), "Only Window"},

  -- tools
  ["<leader>]"] = {projects, "Start Project"},
  ["<leader>'"] = {lazygit_toggle, "Lazygit"},

  -- search
  ["<leader>\\"] = {find_files, "Find Files"},
  ["<leader>b"] = {telescope_builtin.buffers, "Find Buffers"},
  ["<leader>f"] = {telescope_builtin.live_grep, "Find In Files"},
  ["*f"] = {telescope_builtin.grep_string, "Find Under Cursor"},

  -- lsp
  ["gd"] = {lsp_buf.definition, "Go to definition"},
  ["gD"] = {lsp_buf.declaration, "Go to declaration"},
  ["gr"] = {lsp_buf.references, "Go to references"},
  ["gi"] = {lsp_buf.implementation, "Go to implementation"},
  ["gh"] = {hover.render_hover_doc, "Hover doc"},
  ["ga"] = {code_action.code_action, "Code action"},
  ["<C-p>"] = {diagnostic.lsp_jump_diagnostic_prev, "Diagnostic Prev"},
  ["<C-n>"] = {diagnostic.lsp_jump_diagnostic_next, "Diagnostic Next"}
}

whichkey.register({
  ["gc"] = {":<c-u>call CommentOperator(visualmode())<cr>", "Comment Code"}
}, {mode = "v"})

-- Remap ** to * now that we are using * for other bindings
vim.cmd("nnoremap ** *")
