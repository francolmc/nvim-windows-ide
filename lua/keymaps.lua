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
map("n", "<leader>h", ":nohlsearch<CR>", opts)        -- Space+H: Limpiar resaltado de búsqueda

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
map("n", "<F5>", function()                           -- F5: Toggle transparencia Rose Pine
    if vim.g.colors_name == 'rose-pine' then
        local current_bg = vim.api.nvim_get_hl_by_name('Normal', true).background
        if current_bg == nil then
            -- Activar fondo opaco
            vim.api.nvim_set_hl(0, "Normal", { bg = "#191724" })  -- Base color de Rose Pine
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f1d2e" })
            print("🌹 Rose Pine: Transparencia desactivada")
        else
            -- Activar transparencia
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            print("🌹 Rose Pine: Transparencia activada")
        end
    else
        print("⚠️  Toggle transparencia solo funciona con Rose Pine")
    end
end, opts)

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

-- Terminal toggles (toggleterm)
map('n', '<leader>tt', "<CMD>ToggleTerm<CR>", opts)       -- Space+tt: toggle bottom terminal
map('n', '<leader>tf', "<CMD>ToggleTermToggleAll<CR>", opts) -- Space+tf: toggle floating terminals

-- 🔔 Notificaciones
map("n", "<leader>nd", function() require('notify').dismiss() end, opts)  -- Space+nd: Descartar notificaciones
map("n", "<leader>nh", "<CMD>Notifications<CR>", opts)                    -- Space+nh: Ver historial de notificaciones

-- 🌿 Git - Información y navegación (solo lectura)
map("n", "<leader>gb", "<CMD>GitBlameToggle<CR>", opts)                   -- Space+gb: Toggle git blame
map("n", "<leader>gp", function() require('gitsigns').preview_hunk() end, opts)  -- Space+gp: Preview cambios del hunk
map("n", "<leader>gr", function() require('gitsigns').reset_hunk() end, opts)    -- Space+gr: Reset hunk (solo para info)
map("n", "[c", function() require('gitsigns').prev_hunk() end, opts)             -- [c: Ir al hunk anterior
map("n", "]c", function() require('gitsigns').next_hunk() end, opts)             -- ]c: Ir al siguiente hunk
map("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", opts)                            -- Space+gd: Abrir diff view
map("n", "<leader>gh", "<CMD>DiffviewFileHistory<CR>", opts)                     -- Space+gh: Ver historial del archivo
map("n", "<leader>gc", "<CMD>DiffviewClose<CR>", opts)                           -- Space+gc: Cerrar diff view

-- 🤖 IA Agéntica - Autocompletado y Comandos Avanzados

-- AUTOCOMPLETADO AUTOMÁTICO (como VS Code):
-- Tab: Aceptar sugerencia de Copilot (prioridad) o navegar autocompletado
-- Shift+Tab: Sugerencia anterior de Copilot
-- Ctrl+Right: Aceptar solo una palabra de la sugerencia
-- Ctrl+Down: Aceptar solo una línea de la sugerencia
-- Alt+]: Siguiente sugerencia alternativa
-- Alt+[: Sugerencia anterior alternativa
-- Ctrl+C: Rechazar sugerencia

-- Comandos de chat y análisis:
-- Space+ac: Chat, Space+ae: Explicar, Space+ar: Review, Space+at: Tests, Space+af: Fix

-- Comandos agénticos avanzados (requieren selección visual):
-- Space+ao: Optimizar código para rendimiento
-- Space+ad: Generar documentación completa
-- Space+as: Análisis de seguridad
-- Space+ap: Aplicar mejores prácticas por lenguaje
-- Space+ai: Mejorar manejo de errores
-- Space+aa: Análisis completo del archivo (sin selección)

-- GENERACIÓN DE ARCHIVOS Y CÓDIGO:
-- Space+acf: Crear archivo completo con IA (pide nombre y descripción)
-- Space+acg: Generar componente/función (pide tipo, nombre y specs)
-- ¡Los archivos se crean automáticamente con el código generado!

-- 🤖 IA / Copilot keymaps (definidos en la configuración de CopilotChat)
-- Space+ac: Abrir Copilot Chat
-- Space+ae: Explicar código (Ask Copilot)
-- Space+ar: Revisar código (solo en modo visual)
-- Space+at: Generar tests (solo en modo visual)  
-- Space+af: Arreglar código (solo en modo visual)

-- Copilot suggestions keymaps (automáticos con copilot.lua):
-- Tab: Aceptar sugerencia
-- Ctrl+Right: Aceptar palabra
-- Ctrl+L: Aceptar línea
-- Ctrl+]: Siguiente sugerencia
-- Ctrl+[: Sugerencia anterior
-- Ctrl+C: Descartar sugerencia



