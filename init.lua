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
	-- 🎨 Tema VS Code Dark+ 
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		config = function()
			require("vscode").setup({
				style = "dark",
				transparent = false,
				italic_comments = true,
				disable_nvimtree_bg = true,
			})
			require("vscode").load()
		end
	},

	-- 📁 Explorador de archivos lateral (como VS Code)
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				disable_netrw = true,
				hijack_netrw = true,
				view = {
					width = 35,
					side = "left",
				},
				renderer = {
					add_trailing = false,
					group_empty = false,
					highlight_git = true,
					icons = {
						show = { file = true, folder = true, folder_arrow = true, git = true },
					},
				},
				filters = {
					dotfiles = false,
					custom = { "node_modules", ".git" },
				},
				git = { enable = true, ignore = false },
			})
		end
	},

	-- 🔍 Fuzzy finder (Command Palette de VS Code)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = " 🔍 ",
					selection_caret = " ➤ ",
					layout_config = { horizontal = { preview_width = 0.55 } },
				},
				pickers = {
					find_files = { theme = "dropdown", previewer = false },
					live_grep = { theme = "ivy" },
					buffers = { theme = "dropdown", previewer = false },
				},
			})
		end
	},

	-- 📋 Pestañas superiores (como VS Code tabs)
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					separator_style = "slant",
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					color_icons = true,
					diagnostics = "nvim_lsp",
					offsets = {
						{ filetype = "NvimTree", text = "📁 Explorer", highlight = "Directory", text_align = "left" }
					},
				},
			})
		end
	},

	-- 🗺️ Which-key (muestra combinaciones de teclas)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				preset = "modern",
			})
		end
	},
	-- 📊 Statusline (como VS Code)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "vscode",
					globalstatus = true,
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end
	},
	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enable = true, auto_trigger = true },
				panel = { enable = false }
			})
		end
	},
	-- 💡 Autocompletado inteligente (como IntelliSense de VS Code)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets", -- snippets populares
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			
			-- Cargar snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(entry, vim_item)
						-- Iconos para el autocompletado
						local icons = {
							Text = "📝", Method = "🔧", Function = "⚡", Constructor = "🏗️",
							Field = "📄", Variable = "🔢", Class = "🏛️", Interface = "🔗",
							Module = "📦", Property = "🏷️", Unit = "📏", Value = "💎",
							Enum = "📋", Keyword = "🔤", Snippet = "✂️", Color = "🎨",
							File = "📁", Reference = "📖", Folder = "📂", EnumMember = "🏷️",
							Constant = "🔒", Struct = "🏗️", Event = "⚡", Operator = "➕",
							TypeParameter = "📝"
						}
						vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]"
						})[entry.source.name]
						return vim_item
					end
				},
			})
		end
	},
	-- 🧠 LSP (Language Server Protocol) - optimizado para batería
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			
			-- Configuración común para todos los LSPs
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				
				-- Atajos tipo VS Code
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				
				-- Resaltar símbolo bajo cursor (como VS Code)
				if client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd("CursorMoved", {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			-- Configuración específica por lenguaje (sin C/C++)
			local servers = {
				-- TypeScript/JavaScript (actualizado)
				ts_ls = {},
				
				-- Python
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic", -- menos intensivo en batería
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							}
						}
					}
				},
				
				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { 
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME }
							},
							telemetry = { enable = false },
						}
					}
				},
				
				-- Rust (opcional)
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
							cargo = { loadOutDirsFromCheck = true },
							procMacro = { enable = true },
						}
					}
				},
				
				-- Go (opcional)
				gopls = {},
				
				-- JSON
				jsonls = {},
				
				-- HTML/CSS (para desarrollo web)
				html = {},
				cssls = {},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end
		end
	},
	-- 🔧 Mason (instalador automático de LSPs, formatters, etc.)
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- Auto-instalar estos LSPs
				ensure_installed = {
					"ts_ls",        -- TypeScript/JavaScript
					"pyright",      -- Python
					"lua_ls",       -- Lua
					"jsonls",       -- JSON
					"html",         -- HTML
					"cssls",        -- CSS
				},
				automatic_installation = true,
			})
		end
	},

	-- 🔥 Diagnósticos mejorados (como VS Code Problems panel)
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({
				icons = true,
				fold_open = "▾",
				fold_closed = "▸",
				use_diagnostic_signs = true,
			})
		end
	},

	-- 🎯 Comentarios inteligentes
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},

	-- 🎨 Resaltado de colores
	{
		"norcalli/nvim-colorizer.lua",
		ft = { "css", "scss", "html", "javascript", "typescript" },
		config = function()
			require("colorizer").setup()
		end
	},

	-- ⚡ Carga automática de sesiones
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
				options = { "buffers", "curdir", "tabpages", "winsize" }
			})
		end
	},
}, {
	-- ⚡ Configuración de lazy.nvim optimizada para batería
	defaults = {
		lazy = true,      -- lazy load por defecto
		version = false,  -- no usar version tags (más rápido)
	},
	install = {
		missing = true,   -- instalar plugins faltantes automáticamente
		colorscheme = { "vscode" },
	},
	checker = { 
		enabled = false,  -- DESACTIVADO: no check automático de updates (ahorra red/CPU)
	},
	change_detection = {
		enabled = false,  -- DESACTIVADO: no watch de cambios en configs (ahorra CPU)
	},
	performance = {
		rtp = {
			-- Desactivar plugins built-in innecesarios para mejor rendimiento
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",    -- DESACTIVADO: ahorra CPU
				"netrwPlugin",   -- usamos nvim-tree
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- 🎯 Configuraciones automáticas para mejor experiencia tipo VS Code
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Auto-abrir nvim-tree si no se especificó archivo
		if vim.fn.argc() == 0 then
			vim.cmd("NvimTreeOpen")
		end
	end,
})

-- 🔥 Auto-guardar cuando se pierde el foco (como VS Code)
vim.api.nvim_create_autocmd("FocusLost", {
	callback = function()
		vim.cmd("silent! wa")  -- guardar todos los buffers modificados
	end,
})

-- 📏 Resaltar texto copiado
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- 🧹 Limpiar trailing whitespace al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- 💾 Recordar última posición del cursor
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

-- Keymaps
require("keymaps")

-- 🎉 Mensaje de bienvenida
print("🚀 Neovim cargado - Modo VS Code + Batería optimizado")
print("💡 Usa Ctrl+Shift+P para Command Palette, Ctrl+P para buscar archivos")

