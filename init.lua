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
	-- 🎨 Temas con excelente resaltado de sintaxis integrado
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Configuración del tema VS Code con mejor syntax highlighting
			require('vscode').setup({
				-- Habilitar syntax highlighting optimizado
				transparent = false,
				italic_comments = true,
				disable_nvimtree_bg = true,
			})
		end,
	},
	{
		"catppuccin/nvim", 
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = true,
					mini = false,
					-- Integración con LSP para mejor resaltado
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- storm, moon, night, day
				light_style = "day",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,
				-- Configuración para mejor syntax highlighting
				on_colors = function(colors) end,
				on_highlights = function(highlights, colors)
					-- Mejorar resaltado para TypeScript/JavaScript
					highlights.TSKeyword = { fg = colors.purple, style = { italic = true } }
					highlights.TSFunction = { fg = colors.blue }
					highlights.TSVariable = { fg = colors.fg }
					highlights.TSString = { fg = colors.green }
					highlights.TSNumber = { fg = colors.orange }
				end,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require('rose-pine').setup({
				variant = 'auto', -- auto, main, moon, or dawn
				dark_variant = 'main',
				bold_vert_split = false,
				dim_nc_background = false,
				disable_background = true,  -- Fondo transparente principal
				disable_float_background = true,  -- Ventanas flotantes transparentes
				disable_italics = false,
                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },
				groups = {
					background = 'base',
					background_nc = '_experimental_nc',
					panel = 'surface',
					panel_nc = 'base',
					border = 'highlight_med',
					comment = 'muted',
					link = 'iris',
					punctuation = 'subtle',
					error = 'love',
					hint = 'iris',
					info = 'foam',
					warn = 'gold',
					headings = {
						h1 = 'iris',
						h2 = 'foam',
						h3 = 'rose',
						h4 = 'gold',
						h5 = 'pine',
						h6 = 'foam',
					}
				},
				-- Integración con syntax highlighting
				highlight_groups = {
					TSKeyword = { fg = 'pine', italic = true },
					TSFunction = { fg = 'foam' },
					TSString = { fg = 'gold' },
					TSNumber = { fg = 'iris' },
					TSVariable = { fg = 'text' },
				}
			})
		end,
	},

	-- � Rainbow Brackets - Resaltado de paréntesis/llaves (SIN C)
	{

	},

	-- �🌿 Git Signs - Información visual de Git (como VS Code)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
				signs = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signs_staged = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					follow_files = true
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol',
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = 'single',
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1
				},
			})
		end,
	},

	-- 🔍 Git Blame - Ver información de commit por línea
	{
		"f-person/git-blame.nvim",
		config = function()
			require('gitblame').setup({
				enabled = false, -- Deshabilitado por defecto, se activa con keybind
				message_template = ' <summary> • <date> • <author>',
				date_format = '%m-%d-%Y %H:%M:%S',
				virtual_text_column = nil,
			})
		end,
	},

	-- 📊 Git Diff View - Ver diferencias de archivos
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup({
				diff_binaries = false,
				enhanced_diff_hl = false,
				git_cmd = { "git" },
				use_icons = true,
				show_help_hints = true,
				watch_index = true,
				icons = {
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					default = {
						layout = "diff2_horizontal",
						winbar_info = false,
					},
					merge_tool = {
						layout = "diff3_horizontal",
						disable_diagnostics = true,
					},
					file_history = {
						layout = "diff2_horizontal",
						winbar_info = false,
					},
				},
				file_panel = {
					listing_style = "tree",
					tree_options = {
						flatten_dirs = true,
						folder_statuses = "only_folded",
					},
					win_config = {
						position = "left",
						width = 35,
						win_opts = {}
					},
				},
				file_history_panel = {
					log_options = {
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
					},
					win_config = {
						position = "bottom",
						height = 16,
						win_opts = {}
					},
				},
				commit_log_panel = {
					win_config = {
						win_opts = {},
					}
				},
				default_args = {
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				hooks = {},
				keymaps = {
					disable_defaults = false,
					view = {
						{ "n", "<tab>",      require("diffview.actions").select_next_entry,              { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>",    require("diffview.actions").select_prev_entry,              { desc = "Open the diff for the previous file" } },
						{ "n", "gf",         require("diffview.actions").goto_file,                      { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>", require("diffview.actions").goto_file_split,                { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf",    require("diffview.actions").goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e",  require("diffview.actions").focus_files,                    { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b",  require("diffview.actions").toggle_files,                   { desc = "Toggle the file panel." } },
						{ "n", "g<C-x>",     require("diffview.actions").cycle_layout,                   { desc = "Cycle through available layouts." } },
						{ "n", "[x",         require("diffview.actions").prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
						{ "n", "]x",         require("diffview.actions").next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
						{ "n", "<leader>co", require("diffview.actions").conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
						{ "n", "<leader>ct", require("diffview.actions").conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
						{ "n", "<leader>cb", require("diffview.actions").conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
						{ "n", "<leader>ca", require("diffview.actions").conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
						{ "n", "dx",         require("diffview.actions").conflict_choose("none"),        { desc = "Delete the conflict region" } },
					},
					diff1 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff1" }), { desc = "Open the help panel" } },
					},
					diff2 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff2" }), { desc = "Open the help panel" } },
					},
					diff3 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff3" }), { desc = "Open the help panel" } },
					},
					diff4 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff4" }), { desc = "Open the help panel" } },
					},
					file_panel = {
						{ "n", "j",              require("diffview.actions").next_entry,           { desc = "Bring the cursor to the next file entry" } },
						{ "n", "<down>",         require("diffview.actions").next_entry,           { desc = "Bring the cursor to the next file entry" } },
						{ "n", "k",              require("diffview.actions").prev_entry,           { desc = "Bring the cursor to the previous file entry" } },
						{ "n", "<up>",           require("diffview.actions").prev_entry,           { desc = "Bring the cursor to the previous file entry" } },
						{ "n", "<cr>",           require("diffview.actions").select_entry,         { desc = "Open the diff for the selected entry" } },
						{ "n", "o",              require("diffview.actions").select_entry,         { desc = "Open the diff for the selected entry" } },
						{ "n", "l",              require("diffview.actions").select_entry,         { desc = "Open the diff for the selected entry" } },
						{ "n", "<2-LeftMouse>",  require("diffview.actions").select_entry,         { desc = "Open the diff for the selected entry" } },
						{ "n", "-",              require("diffview.actions").toggle_stage_entry,   { desc = "Stage / unstage the selected entry" } },
						{ "n", "S",              require("diffview.actions").stage_all,            { desc = "Stage all entries" } },
						{ "n", "U",              require("diffview.actions").unstage_all,          { desc = "Unstage all entries" } },
						{ "n", "X",              require("diffview.actions").restore_entry,        { desc = "Restore entry to the state on the left side" } },
						{ "n", "L",              require("diffview.actions").open_commit_log,      { desc = "Open the commit log panel" } },
						{ "n", "zo",             require("diffview.actions").open_fold,            { desc = "Expand fold" } },
						{ "n", "h",              require("diffview.actions").close_fold,           { desc = "Collapse fold" } },
						{ "n", "zc",             require("diffview.actions").close_fold,           { desc = "Collapse fold" } },
						{ "n", "za",             require("diffview.actions").toggle_fold,          { desc = "Toggle fold" } },
						{ "n", "zR",             require("diffview.actions").open_all_folds,       { desc = "Expand all folds" } },
						{ "n", "zM",             require("diffview.actions").close_all_folds,      { desc = "Collapse all folds" } },
						{ "n", "<c-b>",          require("diffview.actions").scroll_view(-0.25),   { desc = "Scroll the view up" } },
						{ "n", "<c-f>",          require("diffview.actions").scroll_view(0.25),    { desc = "Scroll the view down" } },
						{ "n", "<tab>",          require("diffview.actions").select_next_entry,    { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>",        require("diffview.actions").select_prev_entry,    { desc = "Open the diff for the previous file" } },
						{ "n", "gf",             require("diffview.actions").goto_file,            { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>",     require("diffview.actions").goto_file_split,      { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf",        require("diffview.actions").goto_file_tab,        { desc = "Open the file in a new tabpage" } },
						{ "n", "i",              require("diffview.actions").listing_style,        { desc = "Toggle between 'list' and 'tree' views" } },
						{ "n", "f",              require("diffview.actions").toggle_flatten_dirs,  { desc = "Flatten empty subdirectories in tree listing style" } },
						{ "n", "R",              require("diffview.actions").refresh_files,        { desc = "Update stats and entries in the file list" } },
						{ "n", "<leader>e",      require("diffview.actions").focus_files,          { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b",      require("diffview.actions").toggle_files,         { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>",         require("diffview.actions").cycle_layout,         { desc = "Cycle through available layouts" } },
						{ "n", "[x",             require("diffview.actions").prev_conflict,        { desc = "Go to the previous conflict" } },
						{ "n", "]x",             require("diffview.actions").next_conflict,        { desc = "Go to the next conflict" } },
						{ "n", "g?",             require("diffview.actions").help("file_panel"),   { desc = "Open the help panel" } },
						{ "n", "<leader>cO",     require("diffview.actions").conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
						{ "n", "<leader>cT",     require("diffview.actions").conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
						{ "n", "<leader>cB",     require("diffview.actions").conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
						{ "n", "<leader>cA",     require("diffview.actions").conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
						{ "n", "dX",             require("diffview.actions").conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
					},
					file_history_panel = {
						{ "n", "g!",            require("diffview.actions").options,                     { desc = "Open the option panel" } },
						{ "n", "<C-A-d>",       require("diffview.actions").open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
						{ "n", "y",             require("diffview.actions").copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
						{ "n", "L",             require("diffview.actions").open_commit_log,             { desc = "Show commit details" } },
						{ "n", "zR",            require("diffview.actions").open_all_folds,              { desc = "Expand all folds" } },
						{ "n", "zM",            require("diffview.actions").close_all_folds,             { desc = "Collapse all folds" } },
						{ "n", "j",             require("diffview.actions").next_entry,                  { desc = "Bring the cursor to the next file entry" } },
						{ "n", "<down>",        require("diffview.actions").next_entry,                  { desc = "Bring the cursor to the next file entry" } },
						{ "n", "k",             require("diffview.actions").prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
						{ "n", "<up>",          require("diffview.actions").prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
						{ "n", "<cr>",          require("diffview.actions").select_entry,                { desc = "Open the diff for the selected entry" } },
						{ "n", "o",             require("diffview.actions").select_entry,                { desc = "Open the diff for the selected entry" } },
						{ "n", "<2-LeftMouse>", require("diffview.actions").select_entry,                { desc = "Open the diff for the selected entry" } },
						{ "n", "<c-b>",         require("diffview.actions").scroll_view(-0.25),          { desc = "Scroll the view up" } },
						{ "n", "<c-f>",         require("diffview.actions").scroll_view(0.25),           { desc = "Scroll the view down" } },
						{ "n", "<tab>",         require("diffview.actions").select_next_entry,           { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>",       require("diffview.actions").select_prev_entry,           { desc = "Open the diff for the previous file" } },
						{ "n", "gf",            require("diffview.actions").goto_file,                   { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>",    require("diffview.actions").goto_file_split,             { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf",       require("diffview.actions").goto_file_tab,               { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e",     require("diffview.actions").focus_files,                 { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b",     require("diffview.actions").toggle_files,                { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>",        require("diffview.actions").cycle_layout,                { desc = "Cycle through available layouts" } },
						{ "n", "g?",            require("diffview.actions").help("file_history_panel"),  { desc = "Open the help panel" } },
					},
					option_panel = {
						{ "n", "<tab>", require("diffview.actions").select_entry,          { desc = "Change the current option" } },
						{ "n", "q",     require("diffview.actions").close,                 { desc = "Close the panel" } },
						{ "n", "g?",    require("diffview.actions").help("option_panel"), { desc = "Open the help panel" } },
					},
					help_panel = {
						{ "n", "q",     require("diffview.actions").close, { desc = "Close help menu" } },
						{ "n", "<esc>", require("diffview.actions").close, { desc = "Close help menu" } },
					},
				},
			})
		end,
	},



	-- 🔴 Error Lens - Mostrar errores en línea (como VS Code)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},

	-- 🎨 Temas
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
						-- Primero revisar si hay sugerencia de Copilot
						local copilot_suggestion = require("copilot.suggestion")
						if copilot_suggestion.is_visible() then
							copilot_suggestion.accept()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							-- Permitir indentación normal cuando no hay sugerencias
							local col = vim.fn.col('.')
							local line = vim.fn.getline('.')
							local before_cursor = line:sub(1, col - 1)

							-- Si estamos al inicio de línea o después de espacios, indentar
							if col == 1 or before_cursor:match('^%s*$') then
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
							else
								fallback()
							end
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						-- Shift+Tab para sugerencia anterior de Copilot
						local copilot_suggestion = require("copilot.suggestion")
						if copilot_suggestion.is_visible() then
							copilot_suggestion.prev()
						elseif cmp.visible() then
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

	-- � Which Key - Mostrar keymaps disponibles (como VS Code Command Palette)
	-- �📁 Oil.nvim - navegador de archivos simple
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
						lualine_b = {'branch', 'diff'},
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

	-- � Sistema de notificaciones moderno
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				fps = 30,
				icons = {
					DEBUG = "",
					ERROR = "✘",
					INFO = "ℹ",
					TRACE = "✎",
					WARN = "▲"
				},
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade_in_slide_out",
				timeout = 3000,
				top_down = true
			})
			-- Usar nvim-notify como sistema de notificaciones por defecto
			vim.notify = require("notify")
		end,
	},

	-- 🎨 Mejoras de UI - noice.nvim (mensajes, cmdline y popupmenu mejorados)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- Sobrescribir markdown rendering para que use treesitter
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- Presets para configuraciones comunes
				presets = {
					bottom_search = true,         -- Usar un search clásico en la parte inferior
					command_palette = true,       -- Posicionar cmdline y popupmenu juntos
					long_message_to_split = true, -- Mensajes largos se envían a split
					inc_rename = false,           -- Habilita input dialog para inc-rename.nvim
					lsp_doc_border = false,       -- Añade borde a hover docs y signature help
				},
				-- Configurar cmdline
				cmdline = {
					enabled = true,
					view = "cmdline_popup",
					opts = {},
					format = {
						cmdline = { pattern = "^:", icon = "", lang = "vim" },
						search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
						search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
						filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
						lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
						help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
						input = {},
					},
				},
				-- Configurar mensajes
				messages = {
					enabled = true,
					view = "notify",
					view_error = "notify",
					view_warn = "notify",
					view_history = "messages",
					view_search = "virtualtext",
				},
				-- Configurar popupmenu
				popupmenu = {
					enabled = true,
					backend = "nui",
					kind_icons = {},
				},
				-- Filtros para reducir ruido
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							find = "%d+L, %d+B",
						},
						view = "mini",
					},
				},
			})
		end,
	},

	-- �🔴 Error Lens - Mostrar errores en línea (como VS Code)
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

	-- Which Key - Mostrar keymaps disponibles
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- Configuración según la documentación oficial v3
			preset = "classic",
			icons = { 
				mappings = false,  -- Deshabilitar iconos automáticos
			},
			win = { 
				border = "rounded",
				padding = { 1, 2 },
			},
			-- No más plugins deprecados o configuraciones antiguas
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function()
			local wk = require("which-key")
			
			-- Registrar keymaps usando wk.add (sintaxis v3)
			wk.add({
				-- Find group
				{ "<leader>f", group = "🔍 Find" },
				{ "<leader>ff", desc = "Find Files" },
				{ "<leader>fg", desc = "Live Grep" },
				{ "<leader>fb", desc = "Buffers" },
				{ "<leader>fh", desc = "Help" },
				
				-- Git group
				{ "<leader>g", group = "🌿 Git" },
				{ "<leader>gb", desc = "Blame" },
				{ "<leader>gp", desc = "Preview Hunk" },
				{ "<leader>gr", desc = "Reset Hunk" },
				{ "<leader>gd", desc = "Diff View" },
				{ "<leader>gh", desc = "History" },
				{ "<leader>gc", desc = "Close Diff" },
				
				-- Terminal group
				{ "<leader>t", group = "🖥️ Terminal" },
				{ "<leader>tt", desc = "Toggle" },
				{ "<leader>tf", desc = "Float" },
				
				-- Notifications group
				{ "<leader>n", group = "🔔 Notify" },
				{ "<leader>nd", desc = "Dismiss" },
				{ "<leader>nh", desc = "History" },
				
				-- Code group
				{ "<leader>c", group = "🔧 Code" },
				{ "<leader>ca", desc = "Action" },
				
				-- Refactor group
				{ "<leader>r", group = "🔄 Refactor" },
				{ "<leader>rn", desc = "Rename" },
				
				-- AI group
				{ "<leader>a", group = "🤖 AI" },
				{ "<leader>ac", desc = "Copilot Chat" },
				{ "<leader>ae", desc = "Explain Code" },
				{ "<leader>ar", desc = "Review Code" },
				{ "<leader>at", desc = "Generate Tests" },
				{ "<leader>af", desc = "Fix Code" },
				
				-- Single mappings
				{ "<leader>l", desc = "🔴 Error Lines" },
			})
		end,
	},

	-- 🤖 Avante.nvim - IA como Cursor IDE con workspace awareness
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		-- ⚠️ CONFIGURACIÓN DE BUILD PARA WINDOWS (documentación oficial)
		build = vim.fn.has("win32") ~= 0
			and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		version = false, -- ⚠️ IMPORTANTE: Never set this to "*"! (documentación)
		---@module 'avante'
		---@type avante.Config
		opts = {
			-- 🎯 CONFIGURACIÓN OPTIMIZADA PARA NO MALGASTAR CRÉDITOS
			provider = "claude", -- Cambiar temporalmente para ver más modelos
			auto_suggestions = false, -- Evitar sugerencias automáticas
			-- 🔒 CONTROL DE CONSUMO DE CRÉDITOS
			providers = {
				copilot = {
					-- ⚡ CONFIGURACIÓN OPTIMIZADA PARA AHORRAR CRÉDITOS
					timeout = 8000, -- Solo 8 segundos máximo (evita requests largos)
					-- ⭐ SIN endpoint ni API key - usa tu Copilot existente automáticamente
					extra_request_body = {
						temperature = 0.0, -- Máxima determinística = menos tokens (nueva ubicación)
						max_tokens = 2048, -- Límite estricto (mitad del máximo)
					},
				},
			},
			-- 📁 Configuración de archivos del proyecto
			instructions_file = "avante.md", -- Archivo de instrucciones por proyecto
			hints = { enabled = false }, -- Sin hints automáticos
			-- 🔍 MEJORES CONFIGURACIONES DE ARCHIVOS
			file_selector = {
				provider = "telescope",
				telescope = {
					theme = "dropdown",
				},
			},
			-- 🪟 Configuración UI optimizada
			windows = {
				position = "right", -- Sidebar derecha como Cursor
				wrap = true,
				width = 30, -- Ancho moderado (30% de pantalla)
				sidebar_header = {
					align = "center",
					rounded = true,
				},
			},
			-- 🛠️ CONFIGURACIÓN DE COMPORTAMIENTO
			behaviour = {
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false, -- Control manual siempre
				support_paste_from_clipboard = true, -- Útil en Windows
				enable_fastapply = false, -- Evitar usar Morph API (cuesta dinero)
			},
			-- 🔧 Configuración de herramientas (usar solo las necesarias)
			disabled_tools = {
				"python", -- Evitar ejecución automática de Python
				"bash",   -- Evitar comandos automáticos en Windows
				"web_search", -- Evitar búsquedas web (cuestan tokens)
				"rag_search", -- Evitar RAG costoso por defecto
			},
			-- 🪟 CONFIGURACIONES ESPECÍFICAS PARA WINDOWS
			web_search_engine = {
				provider = "tavily", -- Solo si necesitas web search
				proxy = nil,
			},
			-- 🔍 CONFIGURAR SELECTORES MEJORES
			selector = {
				provider = "telescope", -- Usar Telescope en lugar del selector nativo
				telescope = {
					theme = "dropdown", -- Tema dropdown para mejor visibilidad
					layout_config = {
						width = 0.8,
						height = 0.6,
					},
				},
			},
		},
		-- 📦 DEPENDENCIAS (según documentación oficial)
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- Dependencias opcionales que ya tienes:
			"nvim-telescope/telescope.nvim", -- file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion para avante commands
			"nvim-tree/nvim-web-devicons", -- iconos
			{
				-- Copilot para Avante (configurado específicamente para no interferir)
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({
						-- ⚡ CONFIGURACIÓN MÍNIMA - Solo para que funcione con Avante
						suggestion = { enabled = false }, -- Desactivar sugerencias automáticas
						panel = { enabled = false }, -- Sin panel
						copilot_node_command = "node", -- Usar node del sistema
					})
				end,
			},
			{
				-- Render markdown mejorado
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
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

-- Habilitar syntax highlighting nativo como base
vim.cmd([[
	syntax enable
	filetype plugin indent on
]])

-- Configuración adicional para mejor resaltado (usando vim.cmd con sintaxis correcta)
-- Mejorar visibilidad de paréntesis emparejados (nativo de Vim)
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Mejores colores para delimitadores usando grupos existentes
vim.cmd([[
	highlight MatchParen guifg=#E06C75 guibg=#3B4048 gui=bold
	highlight Delimiter guifg=#ABB2BF
	highlight Operator guifg=#C678DD
	highlight Special guifg=#61AFEF
]])

-- 🎨 Configurar tema (puedes cambiar aquí)
-- Opciones: 'vscode', 'catppuccin', 'tokyonight', 'rose-pine'
vim.cmd.colorscheme('rose-pine')  -- Cambia por el que prefieras

-- 🌟 Configuraciones adicionales de transparencia para Rose Pine
if vim.g.colors_name == 'rose-pine' then
    -- Hacer transparentes los elementos principales
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    
    -- Transparencia para barras laterales y ventanas
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    
    -- Transparencia para Telescope
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    
    -- Transparencia para Which-Key
    vim.api.nvim_set_hl(0, "WhichKey", { bg = "none" })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
    
    -- Transparencia para terminal
    vim.api.nvim_set_hl(0, "TerminalNormal", { bg = "none" })
    
    -- Mantener bordes visibles pero transparentes
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#9ccfd8" })  -- Color foam de Rose Pine
    
    print("🌹 Rose Pine con transparencia activada")
end

-- 🎉 Mensaje de bienvenida
print("📝 Neovim con Oil, Telescope y LSP cargado correctamente!")
print("🔍 Avante: Selectores mejorados con Telescope")
print("⌨️  Usa Ctrl+S para guardar, Ctrl+A para seleccionar todo")
print("🔍 Usa Space+ff para buscar archivos, Space+fg para buscar contenido")
print("📁 Usa Ctrl+E para explorador de archivos")
print("🖥️  Usa Space+t para terminal inferior")
print("� LSP + nvim-cmp: Autocompletado nativo con Tab")
print("🔴 Los errores LSP se muestran en línea (como VS Code Error Lens)")
print("� Tip: Autentica Copilot con :Copilot auth")
print("�📂 Directorio actual: " .. vim.fn.getcwd())
