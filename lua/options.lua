-- ⚙️ Configuración básica del editor
local opt = vim.opt

-- 🧭 Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 🖋️ Interfaz básica
opt.number = true               -- números de línea
opt.relativenumber = true       -- números relativos (útil para movimiento)
opt.cursorline = true           -- resaltar línea actual
opt.termguicolors = true        -- colores 24-bit
opt.signcolumn = "yes"          -- columna para signos
opt.scrolloff = 4               -- margen vertical
opt.sidescrolloff = 8           -- margen horizontal

-- ⌨️ Edición
opt.expandtab = true            -- usar espacios en vez de tabs
opt.shiftwidth = 2              -- indentación de 2 espacios
opt.tabstop = 2                 -- ancho del tab
opt.smartindent = true          -- indentación inteligente
opt.wrap = false                -- no dividir líneas largas

-- 🔍 Búsqueda
opt.ignorecase = true           -- ignorar mayúsculas al buscar
opt.smartcase = true            -- respetar mayúsculas si se usan
opt.incsearch = true            -- mostrar resultados mientras se escribe
opt.hlsearch = true             -- resaltar coincidencias

-- 📋 Portapapeles
opt.clipboard = "unnamedplus"   -- usar portapapeles del sistema

-- 💾 Archivos
opt.undofile = true             -- historial persistente de cambios
opt.swapfile = false            -- desactivar archivos swap
opt.backup = false              -- desactivar backups

-- ⚡ Rendimiento
opt.updatetime = 250            -- tiempo de actualización
opt.timeoutlen = 400            -- tiempo para combos de teclas

-- 🖼️ Divisiones
opt.splitright = true           -- nuevas divisiones verticales a la derecha
opt.splitbelow = true           -- nuevas divisiones horizontales abajo

-- 🐁 Mouse
opt.mouse = "a"                 -- habilitar mouse en todos los modos

-- 🌍 Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- � Formato visual
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣"
}

-- 🔔 Sin sonidos
opt.belloff = "all"

-- 🎪 Windows específico
if vim.fn.has("win32") == 1 then
  opt.shell = "pwsh.exe"
end
