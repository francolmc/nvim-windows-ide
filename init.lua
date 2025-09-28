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

	-- 🔍 Telescope - Buscador de archivos y contenido (como VS Code)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { 
			"nvim-lua/plenary.nvim",           -- requerido por telescope
			"nvim-tree/nvim-web-devicons",     -- iconos bonitos
		},
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "🔍 ",         -- icono de búsqueda
					selection_caret = "➤ ",        -- cursor de selección
					path_display = { "truncate" }, -- mostrar rutas truncadas
					file_ignore_patterns = {       -- ignorar estos archivos/carpetas
						"node_modules/",
						".git/",
						"%.exe",
						"%.dll",
						"%.zip",
						"%.rar"
					},
					-- Configuración para ventana flotante centrada
					layout_strategy = "center",
					layout_config = {
						center = {
							width = 0.8,               -- 80% del ancho
							height = 0.6,              -- 60% del alto
							preview_cutoff = 20,       -- mostrar preview solo si hay espacio
						}
					},
					sorting_strategy = "ascending",
					winblend = 10,                     -- ligera transparencia
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
				pickers = {
					-- Configuración específica para buscar archivos
					find_files = {
						hidden = true,                 -- incluir archivos ocultos
						previewer = true,              -- mostrar preview
					},
					-- Configuración para buscar en contenido
					live_grep = {
						-- Sin configuración personalizada - usar defaults de telescope
					},
					-- Configuración para buffers abiertos
					buffers = {
						previewer = false,
						sort_lastused = true,          -- ordenar por último usado
						sort_mru = true,               -- most recently used first
					},
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
print("📝 Neovim con Oil y Telescope cargado correctamente!")
print("⌨️  Usa Ctrl+S para guardar, Ctrl+A para seleccionar todo")
print("🔍 Usa Space+ff para buscar archivos, Space+fg para buscar contenido")
print("📁 Usa Ctrl+E para explorador de archivos")
print("📂 Directorio actual: " .. vim.fn.getcwd())
