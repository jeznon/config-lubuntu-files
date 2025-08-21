-- General Neovim settings
vim.cmd [[set shortmess+=c]]
local copilot_select = require("CopilotChat.select")

vim.o.splitright = true -- Always open vertical splits to the right
vim.o.splitbelow = true -- Always open horizontal splits below

require("telescope").load_extension("ui-select")

-- Custom Copilot highlight
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#0000ff", bg = "#ff69b4" }) -- Blue over pink


-- ===============================
-- Copilot setup
-- ===============================
require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-y>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { enabled = false },
})

require("copilot_cmp").setup()


-- ===============================
-- nvim-cmp setup
-- ===============================
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name ='copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "copilot" then
        vim_item.kind = " Copilot"
        vim_item.kind_hl_group = "CmpItemKindCopilot"
      end
      return vim_item
    end,
  },
})


-- ===============================
-- Keymaps for Copilot / Luasnip / CMP
-- ===============================
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_get_current_line():sub(col, col):match("%s") == nil
end

local copilot = require("copilot.suggestion")
local luasnip = require("luasnip")

vim.keymap.set("i", "<Tab>", function()
  if copilot.is_visible() then
    copilot.accept()
    return ""
  elseif luasnip.expand_or_jumpable() then
    return vim.fn["luasnip#expand_or_jump"]()
  elseif cmp.visible() then
    cmp.select_next_item()
    return ""
  elseif has_words_before() then
    cmp.complete()
    return ""
  else
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  end
end, { expr = true, silent = true })

vim.keymap.set("i", "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    return vim.fn["luasnip#jump"](-1)
  elseif cmp.visible() then
    cmp.select_prev_item()
    return ""
  else
    return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
  end
end, { expr = true, silent = true })


-- ===============================
-- Command-line completion
-- ===============================
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})


-- ===============================
-- Notify setup
-- ===============================
local notify = require("notify")
notify.setup({
  stages = "fade",
  timeout = 3000,
  background_colour = "#000000",
  fps = 60,
  render = "minimal",
  top_down = true,
  max_width = 60,
  max_height = 10,
  icons = {
    ERROR = "",
    WARN  = "",
    INFO  = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
vim.notify = notify


-- ===============================
-- Noice setup
-- ===============================
require("noice").setup({
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  routes = {
    { filter = { event = "msg_show", find = "Copilot" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "CopilotChatWindow" }, opts = { skip = true } },
  },
  views = {
    cmdline_popup = {
      position = { row = "50%", col = "50%" },
      size = { width = "auto", height = "auto" },
      border = { style = "rounded", padding = { 1, 2 } },
    },
    popup = { border = { style = "rounded", padding = { 1, 2 } } },
  },
})


-- ===============================
-- Alpha Dashboard
-- ===============================
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  "    ▄▄▄▄▄                               ",
  "    ▀▀▀██                               ",
  "       ██   ▄████▄   ▄▄█████▄  ▄▄█████▄ ",
  "       ██  ██▄▄▄▄██  ██▄▄▄▄ ▀  ██▄▄▄▄ ▀ ",
  "       ██  ██▀▀▀▀▀▀   ▀▀▀▀██▄   ▀▀▀▀██▄ ",
  " █▄▄▄▄▄██  ▀██▄▄▄▄█  █▄▄▄▄▄██  █▄▄▄▄▄██ ",
  "  ▀▀▀▀▀      ▀▀▀▀▀    ▀▀▀▀▀▀    ▀▀▀▀▀▀  ",
}
dashboard.section.buttons.val = {
  dashboard.button("v", "  Neovim config", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "❌  Quit", ":q<CR>"),
}
alpha.setup(dashboard.config)


-- ===============================
-- Lualine setup
-- ===============================
require('lualine').setup {
  options = {
    theme = "auto",
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename" },
      { function() return vim.fn.fnamemodify(vim.fn.getcwd(), ":~") end, icon = "" },
    },
    lualine_x = {
      { function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = { fg = "#ff9e64" }, },
      { function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = { fg = "#7aa2f7" }, },
    },
    lualine_y = { { "progress" }, { "location" } },
    lualine_z = { function() return " " .. os.date("%R") end },
  },
  extensions = { "neo-tree", "fugitive" },
}


-- ===============================
-- Indent guides
-- ===============================
local highlight = {
  "RainbowRed", "RainbowYellow", "RainbowBlue",
  "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
require("ibl").setup { indent = { highlight = highlight, char = "┊" } }


-- ===============================
-- Transparency
-- ===============================
vim.cmd [[
  colorscheme tokyonight
  highlight Normal guibg=NONE ctermbg=NONE
]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

