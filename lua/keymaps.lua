-- 🎯 Keymaps básicos para edición
local map = vim.keymap.set
local opts = { silent = true }

-- 💾 Archivo básico
map("n", "<C-s>", ":w<CR>", opts)                     -- Ctrl+S: Guardar
map("i", "<C-s>", "<ESC>:w<CR>a", opts)               -- Ctrl+S en modo insertar
map("n", "<C-q>", ":q<CR>", opts)                     -- Ctrl+Q: Salir
map("n", "<C-n>", ":enew<CR>", opts)                  -- Ctrl+N: Nuevo archivo

-- 📋 Copia, corta y pega (funciona con portapapeles del sistema)
map("n", "<C-a>", "ggVG", opts)                       -- Ctrl+A: Seleccionar todo
map("v", "<C-c>", '"+y', opts)                        -- Ctrl+C: Copiar selección
map("n", "<C-c>", '"+yy', opts)                       -- Ctrl+C: Copiar línea
map("v", "<C-x>", '"+x', opts)                        -- Ctrl+X: Cortar selección
map("n", "<C-v>", '"+p', opts)                        -- Ctrl+V: Pegar después del cursor
map("i", "<C-v>", '<C-r>+', opts)                     -- Ctrl+V: Pegar en modo insertar

-- 🔍 Búsqueda básica
map("n", "<C-f>", "/", { silent = false })            -- Ctrl+F: Buscar
map("n", "<Esc>", ":nohlsearch<CR>", opts)            -- ESC: Limpiar resaltado de búsqueda

-- 🧭 Navegación básica
map("n", "<C-Home>", "gg", opts)                      -- Ctrl+Home: Ir al inicio
map("n", "<C-End>", "G", opts)                        -- Ctrl+End: Ir al final
map("n", "<Home>", "^", opts)                         -- Home: Ir al inicio de línea (sin espacios)
map("n", "<End>", "$", opts)                          -- End: Ir al final de línea

-- ⌨️ Edición básica
map("n", "<C-z>", "u", opts)                          -- Ctrl+Z: Deshacer
map("n", "<C-y>", "<C-r>", opts)                      -- Ctrl+Y: Rehacer
map("i", "<C-Backspace>", "<C-w>", opts)              -- Ctrl+Backspace: Borrar palabra
map("i", "<C-Delete>", "<C-o>dw", opts)               -- Ctrl+Delete: Borrar palabra siguiente

-- 🔢 Números de línea y utilidades
map("n", "<F3>", ":set number!<CR>", opts)            -- F3: Toggle números de línea
map("n", "<F4>", ":set list!<CR>", opts)              -- F4: Toggle caracteres invisibles

-- 🖥️ Terminal integrada básica
map("n", "<C-`>", ":split | terminal<CR>", opts)      -- Ctrl+`: Abrir terminal
map("t", "<Esc>", [[<C-\><C-n>]], opts)               -- ESC: Salir del modo terminal

-- 📁 Oil - Navegador de archivos
map("n", "<leader>e", "<CMD>Oil<CR>", opts)           -- Space+E: Abrir Oil
map("n", "<C-e>", "<CMD>Oil<CR>", opts)               -- Ctrl+E: Abrir Oil
map("n", "<leader>E", function()                      -- Space+E (mayúscula): Oil flotante
  require("oil").open_float()
end, opts)

-- 🔍 Telescope - Buscador tipo VS Code
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, opts)                                                      -- Space+ff: Buscar archivos
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, opts)                                                      -- Space+fg: Buscar en contenido
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)      -- Space+fb: Buscar buffers
map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", opts)    -- Space+fh: Buscar ayuda



