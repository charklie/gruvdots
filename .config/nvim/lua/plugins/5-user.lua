-- User plugins
-- Plugins added by the user, not apart of NormalNvim.

local lspconfig = require("lspconfig")
lspconfig.sourcekit.setup({})
lspconfig.harper_ls.setup({
  settings = {
    ["harper-ls"] = {
      linters = {
        spell_check = false,
        sentence_capitalization = false,
      },
    },
  },
})

lspconfig.v_analyzer.setup({})

return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
        --    SignColumn = { bg = "#282828" },
        --    FoldColumn = { bg = "#282828" },
      },
    },
  },
  { "rose-pine/neovim",      name = "rosepine" },
  { "rebelot/kanagawa.nvim", name = "kanagawa" },
  { "Mofiqul/dracula.nvim",  name = "dracula" },
}
