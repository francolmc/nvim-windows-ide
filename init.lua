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
	-- 📁 Oil.nvim - navegador de archivos simple
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,  -- reemplazar netrw
				columns = { "icon" },           -- mostrar solo iconos
				view_options = {
					show_hidden = true,         -- mostrar archivos ocultos
				},
				float = {
					padding = 2,
					max_width = 80,
					max_height = 25,
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-v>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-r>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["q"] = "actions.close",
				},
			})
		end
	},
}, {
	-- Configuración de lazy.nvim
	defaults = {
		lazy = false,     -- cargar plugins inmediatamente para simplicidad
	},
	install = {
		missing = true,   -- instalar plugins faltantes automáticamente
	},
	checker = { 
		enabled = false,  -- no check automático de updates
	},
	change_detection = {
		enabled = false,  -- no watch de cambios en configs
	},
})

-- Keymaps básicos
require("keymaps")

-- 🎉 Mensaje de bienvenida
print("� Neovim básico cargado correctamente!")
print("⌨️  Usa Ctrl+S para guardar, Ctrl+A para seleccionar todo")
print("🔍 Usa Ctrl+F para buscar, F3 para toggle números de línea")

