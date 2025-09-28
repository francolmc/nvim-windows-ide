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

-- Suprimir warnings de lspconfig deprecation temporalmente
vim.g.lspconfig_deprecation_warnings = false

require("lazy").setup({
	-- 🎨 Temas Dark populares
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"catppuccin/nvim", 
		name = "catppuccin",
		lazy = false,
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
	},

	-- 🧠 LSP y Autocompletado (SIN C - solo herramientas nativas)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Mason - gestor de LSP servers (sin compilación C)
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Configurar Mason primero
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})

			-- LSP servers que NO requieren compilación C
			local servers = {
				-- JavaScript/TypeScript (Node.js based)
				"ts_ls",           -- TypeScript/JavaScript
				"html",            -- HTML
				"cssls",           -- CSS
				"jsonls",          -- JSON
				
				-- Python (Python based)
				"pylsp",           -- Python LSP (pure Python, no C)
				
				-- Lua (Lua based)
				"lua_ls",          -- Lua
				
				-- Rust (Rust based - sin C dependencies)
				"rust_analyzer",   -- Rust
			}

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_installation = true,
			})

			-- Configurar cada LSP server
			-- Las capabilities se configuran en nvim-cmp para mejor integración
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			
			-- Función común para configurar mapeos LSP
			local function on_attach(client, bufnr)
				local map = vim.keymap.set
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				
				map('n', 'gd', vim.lsp.buf.definition, bufopts)
				map('n', 'K', vim.lsp.buf.hover, bufopts)
				map('n', 'gi', vim.lsp.buf.implementation, bufopts)
				map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
				map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
				map('n', 'gr', vim.lsp.buf.references, bufopts)
				map('n', '<leader>f', function()
					vim.lsp.buf.format { async = true }
				end, bufopts)
				
				-- Toggle para activar/desactivar lsp_lines
				map('n', '<leader>l', function()
					require("lsp_lines").toggle()
				end, bufopts)
			end

			-- Suprimir temporalmente warnings de deprecation
			local old_notify = vim.notify
			vim.notify = function(msg, level, opts)
				if msg and msg:match("lspconfig.*deprecated") then
					return
				end
				old_notify(msg, level, opts)
			end

			-- Configurar cada servidor
			for _, server in ipairs(servers) do
				local opts = {
					capabilities = capabilities,
					on_attach = on_attach,
				}

				-- Configuraciones específicas por servidor
				if server == "lua_ls" then
					opts.settings = {
						Lua = {
							runtime = { version = 'LuaJIT' },
							diagnostics = { globals = {'vim'} },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					}
				elseif server == "ts_ls" then
					opts.settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = 'all',
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							}
						}
					}
				end

				-- Usar lspconfig tradicional (funciona bien)
				require("lspconfig")[server].setup(opts)
			end

			-- Restaurar vim.notify después de configurar LSP
			vim.notify = old_notify
		end,
	},

	-- 💬 Autocompletado nativo (sin cmp-nvim para evitar C)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",     -- LSP source
			"hrsh7th/cmp-buffer",       -- Buffer source
			"hrsh7th/cmp-path",         -- Path source
			"hrsh7th/cmp-cmdline",      -- Command line source
			-- Snippets (SIN luasnip para evitar C)
			"rafamadriz/friendly-snippets", -- Snippets collection
			"saadparwaiz1/cmp_luasnip",     -- Snippet source
			"L3MON4D3/LuaSnip",             -- Snippet engine (pure Lua)
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Cargar snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Configurar capabilities para LSP
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			
			-- Actualizar capabilities en lspconfig si ya está configurado
			if package.loaded['lspconfig'] then
				for _, server in ipairs({'lua_ls', 'ts_ls', 'html', 'cssls', 'jsonls', 'pylsp', 'rust_analyzer'}) do
					if package.loaded['lspconfig'][server] then
						require('lspconfig')[server].setup({ capabilities = capabilities })
					end
				end
			end

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
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },    -- LSP
					{ name = 'luasnip' },     -- Snippets
				}, {
					{ name = 'buffer' },      -- Buffer actual
					{ name = 'path' },        -- Rutas de archivos
				}),
				-- Iconos para el autocompletado
				formatting = {
					format = function(entry, vim_item)
						-- Iconos para diferentes tipos
						local icons = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰜢",
							Variable = "󰀫",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "",
						}
						vim_item.kind = string.format('%s %s', icons[vim_item.kind] or "", vim_item.kind)
						return vim_item
					end
				}
			})

			-- Autocompletado para búsqueda
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Autocompletado para comandos
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end,
	},

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

	-- 📊 Statusline - lualine (pure Lua) - configuración simplificada
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Configuración mínima sin secciones complejas
			local ok, lualine = pcall(require, 'lualine')
			if ok then
				lualine.setup({
					options = {
						theme = 'auto',
						section_separators = '',
						component_separators = '',
						disabled_filetypes = {},
						globalstatus = false,
					},
					sections = {
						lualine_a = {'mode'},
						lualine_b = {'branch'},
						lualine_c = {'filename'},
						lualine_x = {
							-- Diagnósticos con iconos consistentes
							{
								'diagnostics',
								sources = {'nvim_lsp'},
								symbols = {
									error = '✘ ',
									warn = '▲ ',
									info = 'ℹ ',
									hint = '💡 '
								},
								colored = true,
								update_in_insert = false,
								always_visible = false,
							},
							'filetype'
						},
						lualine_y = {'progress'},
						lualine_z = {'location'}
					},
				})
			end
		end,
	},

	-- 🖥️ Terminal inferior - toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require('toggleterm').setup{
				size = 20,
				autostart = false,
				open_mapping = false,
				shade_terminals = true,
				direction = 'horizontal', -- bottom panel
				float_opts = { border = 'curved' },
			}
		end,
	},

	-- 🔴 Error Lens - Mostrar errores en línea (como VS Code)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			
			-- Configurar iconos consistentes para diagnósticos (iconos más comunes)
			local signs = {
				Error = "✘",  -- X para error (más compatible)
				Warn  = "▲",  -- Triángulo para warning  
				Hint  = "💡", -- Bombilla para hint/sugerencia
				Info  = "ℹ",  -- i para información
			}
			
			-- Aplicar iconos a los signos del margen
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			
			-- Configurar diagnósticos con iconos consistentes
			vim.diagnostic.config({
				virtual_text = {
					prefix = function(diagnostic)
						-- Usar iconos consistentes en el texto virtual (más compatibles)
						local icons = {
							[vim.diagnostic.severity.ERROR] = "✘",
							[vim.diagnostic.severity.WARN]  = "▲",
							[vim.diagnostic.severity.HINT]  = "💡",
							[vim.diagnostic.severity.INFO]  = "ℹ",
						}
						return icons[diagnostic.severity] or "●"
					end,
					source = "always",
					spacing = 4,
					format = function(diagnostic)
						return string.format("%s", diagnostic.message)
					end,
				},
				virtual_lines = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN]  = "▲",
						[vim.diagnostic.severity.HINT]  = "💡",
						[vim.diagnostic.severity.INFO]  = "ℹ",
					}
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
					format = function(diagnostic)
						local icon = ({
							[vim.diagnostic.severity.ERROR] = "✘ ",
							[vim.diagnostic.severity.WARN]  = "▲ ",
							[vim.diagnostic.severity.HINT]  = "💡 ",
							[vim.diagnostic.severity.INFO]  = "ℹ ",
						})[diagnostic.severity] or "● "
						return icon .. diagnostic.message
					end,
				},
			})
		end,
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

-- 🎨 Configurar tema (puedes cambiar aquí)
-- Opciones: 'vscode', 'catppuccin', 'tokyonight', 'rose-pine'
vim.cmd.colorscheme('vscode')  -- Cambia por el que prefieras

-- 🎉 Mensaje de bienvenida
print("📝 Neovim con Oil, Telescope y LSP cargado correctamente!")
print("⌨️  Usa Ctrl+S para guardar, Ctrl+A para seleccionar todo")
print("🔍 Usa Space+ff para buscar archivos, Space+fg para buscar contenido")
print("📁 Usa Ctrl+E para explorador de archivos")
print("🖥️  Usa Space+t para terminal inferior")
print("🔴 Los errores LSP se muestran en línea (como VS Code Error Lens)")
print("📂 Directorio actual: " .. vim.fn.getcwd())