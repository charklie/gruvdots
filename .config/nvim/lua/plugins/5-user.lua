-- User plugins
-- Plugins added by the user, not apart of NormalNvim.

local lspconfig = require("lspconfig")
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

return {
  { "ellisonleao/gruvbox.nvim",         name = "gruvbox" },
  { "rose-pine/neovim",                 name = "rosepine" },
  { "rebelot/kanagawa.nvim",            name = "kanagawa" },
  { "Mofiqul/dracula.nvim",             name = "dracula" },
  { 'andweeb/presence.nvim' },
  { "frabjous/knap" },
  { 'muellerbernd/latex-previewer.nvim' },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
}
