-- ⚙️ Configuración básica del editor
local opt = vim.opt

-- 🧭 Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 🖋️ Interfaz básica
opt.number = true               -- números de línea
opt.relativenumber = false      -- sin números relativos (más simple)
opt.cursorline = true           -- resaltar línea actual
opt.termguicolors = true        -- colores 24-bit
opt.signcolumn = "yes"          -- columna para signos
opt.scrolloff = 4               -- margen vertical
opt.sidescrolloff = 8           -- margen horizontal

-- ⌨️ Edición con 4 espacios
opt.expandtab = true            -- usar espacios en vez de tabs
opt.shiftwidth = 4              -- indentación de 4 espacios
opt.tabstop = 4                 -- ancho del tab = 4 espacios
opt.softtabstop = 4             -- backspace elimina 4 espacios
opt.smartindent = true          -- indentación inteligente
opt.autoindent = true           -- mantener indentación
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
opt.autowrite = true            -- guardar automáticamente
opt.autoread = true             -- recargar archivos cambiados

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

-- 📏 Formato visual
opt.list = true
opt.listchars = {
  tab = "  ",                   -- tabs como dos espacios (mínimo requerido)
  trail = "·",                  -- mostrar espacios al final
  nbsp = "␣"                    -- mostrar espacios no separables
}

-- 🔔 Sin sonidos
opt.belloff = "all"

-- 🎪 Windows específico
if vim.fn.has("win32") == 1 then
  opt.shell = "pwsh.exe"
  opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  opt.shellquote = ""
  opt.shellxquote = ""
end

-- 🎨 Configuración adicional
opt.showmode = true             -- mostrar el modo actual
opt.showcmd = true              -- mostrar comandos parciales
opt.ruler = true                -- mostrar posición del cursor
opt.laststatus = 2              -- siempre mostrar statusline
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 15              -- máximo 15 elementos en menú