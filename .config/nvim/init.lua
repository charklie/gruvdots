-- HELLO, welcome to NormalNvim!
-- ---------------------------------------
-- This is the entry point of your config.
-- ---------------------------------------



local function load_source(source)
  local status_ok, error = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. error)
  end
end

local function load_sources(source_files)
  vim.loader.enable()
  for _, source in ipairs(source_files) do
    load_source(source)
  end
end

local function load_sources_async(source_files)
  for _, source in ipairs(source_files) do
    vim.defer_fn(function() load_source(source) end, 50)
  end
end

local function load_colorscheme_async(colorscheme)
  vim.defer_fn(function()
    if vim.g.default_colorscheme then
      if not pcall(vim.cmd.colorscheme, colorscheme) then
        require("base.utils").notify(
          "Error setting up colorscheme: " .. colorscheme,
          vim.log.levels.ERROR
        )
      end
    end
  end, 0)
end

-- Call the functions defined above.
load_sources({
  "base.1-options",
  "base.2-lazy",
  "base.3-autocmds", -- critical stuff, don't change the execution order.
})

load_sources_async({ "base.4-mappings" })
load_colorscheme_async(vim.g.default_colorscheme)

local io = require("io")

local function get_file_contents(filePath)
  if not filePath then return "" end
  local content = ""
  local file = io.open(filePath, "r")
  if file then
    while true do
      local line = file:read("*l")
      if not line then break end
      content = content .. line .. "\n"
    end
    file:close()
  else
    error("Failed to open file: " .. filePath)
  end

  return content
end

local content_colorscheme_file = get_file_contents("/home/charlie/.config/waybar/active_colorscheme.txt")

if content_colorscheme_file ~= "gruvbox_light" or content_colorscheme_file ~= "gruvbox_light" then
  vim.g.default_colorscheme = content_colorscheme_file
  vim.o.background = "dark"
elseif content_colorscheme_file == "gruvbox_dark" then
  vim.g.default_colorscheme = "gruvbox"
  vim.o.background = "dark"
elseif content_colorscheme_file == "gruvbox_light" then
  vim.g.default_colorscheme = "gruvbox"
  vim.o.background = "light"
end

vim.cmd("colorscheme " .. vim.g.default_colorscheme)
