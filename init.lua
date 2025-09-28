-- 🚀 Configuración básica de Neovim
require("options")

-- 📦 Cargar lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	
})

-- Keymaps
require("keymaps")

-- 🎉 Mensaje de bienvenida
print("🚀 Neovim cargado - Modo VS Code + Batería optimizado")
print("💡 Usa Ctrl+Shift+P para Command Palette, Ctrl+P para buscar archivos")

