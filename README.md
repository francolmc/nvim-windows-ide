# 🚀 Configuración de Neovim para Windows 11

Una configuración de Neovim optimizada para Windows 11, diseñada para ser similar a VS Code pero más eficiente en el uso de batería.

## 📋 Requisitos Previos

### 🖥️ Sistema Operativo
- Windows 11
- PowerShell (incluido por defecto)

### 🛠️ Instalaciones Necesarias

#### 1. Neovim
```powershell
winget install Neovim.Neovim
```

#### 2. Git (si no está instalado)
```powershell
winget install Git.Git
```

#### 3. Ripgrep (para búsqueda de contenido)
```powershell
winget install BurntSushi.ripgrep.MSVC
```

#### 4. fd (para búsqueda de archivos, opcional pero recomendado)
```powershell
winget install sharkdp.fd
```

#### 5. Una Nerd Font (para iconos)
```powershell
# Instalar JetBrains Mono Nerd Font
winget install DEVCOM.JetBrainsMonoNerdFont
```

## 📁 Estructura de Archivos

```
C:\Users\{tu_usuario}\AppData\Local\nvim\
├── init.lua           # Configuración principal
├── lazy-lock.json     # Lock file de plugins (auto-generado)
└── lua\
    ├── options.lua    # Configuración del editor
    └── keymaps.lua    # Mapeo de teclas
```

## 🔧 Instalación

1. **Crear directorio de configuración:**
```powershell
mkdir "$env:LOCALAPPDATA\nvim\lua"
```

2. **Copiar archivos de configuración:**
   - `init.lua` → `$env:LOCALAPPDATA\nvim\init.lua`
   - `options.lua` → `$env:LOCALAPPDATA\nvim\lua\options.lua`
   - `keymaps.lua` → `$env:LOCALAPPDATA\nvim\lua\keymaps.lua`

3. **Primera ejecución:**
```powershell
nvim
```
Los plugins se instalarán automáticamente en la primera ejecución.

## ⌨️ Atajos de Teclado Principales

### 📝 Edición Básica
- `Ctrl+S` - Guardar archivo
- `Ctrl+A` - Seleccionar todo
- `Ctrl+C` - Copiar
- `Ctrl+V` - Pegar
- `Ctrl+X` - Cortar
- `Ctrl+Z` - Deshacer
- `Ctrl+Y` - Rehacer

### 🔍 Búsqueda (Telescope)
- `Space + ff` - Buscar archivos
- `Space + fg` - Buscar en contenido
- `Space + fb` - Buscar buffers abiertos
- `Space + fh` - Buscar en ayuda

### 📁 Navegación
- `Ctrl+E` - Abrir explorador de archivos (Oil)
- `Ctrl+Q` - Cerrar
- `Ctrl+N` - Nuevo archivo

### 🖥️ Terminal
- `Ctrl+\`` - Abrir terminal integrada
- `Esc` (en terminal) - Salir del modo terminal

## 🎨 Temas Disponibles

La configuración incluye varios temas dark:

1. **VS Code** (por defecto) - `vscode`
2. **Catppuccin** - `catppuccin`
3. **Tokyo Night** - `tokyonight`
4. **Rose Pine** - `rose-pine`

### Cambiar tema:
Edita `init.lua` línea ~134:
```lua
vim.cmd.colorscheme('nombre_del_tema')
```

O usa el comando en Neovim:
```vim
:colorscheme nombre_del_tema
```

## 🔌 Plugins Incluidos

- **lazy.nvim** - Gestor de plugins rápido
- **Oil.nvim** - Explorador de archivos integrado
- **Telescope** - Buscador fuzzy (archivos y contenido)
- **nvim-web-devicons** - Iconos para archivos
- **Temas múltiples** - VS Code, Catppuccin, Tokyo Night, Rose Pine

## 🩺 Verificar Instalación

Ejecuta en Neovim:
```vim
:checkhealth
:checkhealth telescope
```

## 🔧 Solución de Problemas

### Ripgrep no funciona
```powershell
# Reinicia PowerShell después de instalar ripgrep
# O verifica que esté en PATH:
rg --version
```

### fd no funciona
```powershell
# Reinicia PowerShell después de instalar fd
# O verifica que esté en PATH:
fd --version
```

### Telescope no encuentra archivos
1. Verifica que `ripgrep` y `fd` estén instalados
2. Reinicia Neovim
3. Ejecuta `:checkhealth telescope`

### Iconos no se muestran
1. Instala una Nerd Font
2. Configura tu terminal para usar la Nerd Font
3. Reinicia el terminal

## 💡 Características

- ⚡ **Optimizado para batería** - Carga lazy de plugins
- 🎯 **Similar a VS Code** - Atajos y comportamiento familiar  
- 🪟 **Compatible con Windows** - Sin dependencias de C
- 🔍 **Búsqueda potente** - Archivos y contenido con Telescope
- 📁 **Explorador integrado** - Oil.nvim para navegación
- 🎨 **Múltiples temas** - Varios temas dark incluidos

## 📝 Notas

- La configuración se guarda automáticamente con `Ctrl+S`
- Los plugins se actualizan automáticamente si es necesario
- Compatible con clipboard del sistema
- Optimizado para uso prolongado con batería

---

**¡Disfruta tu nueva configuración de Neovim! 🎉**