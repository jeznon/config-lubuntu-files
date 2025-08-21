# 🌸 Mi configuración de Rofi

Este es mi setup de [Rofi](https://github.com/davatorium/rofi) en Linux.  
Minimalista, rápido y con un toque personal ✨.

## 📂 Contenido
- `config.rasi` → archivo principal de configuración
- `themes/` → mis temas personalizados
![Vista previa de mi Rofi](rofi/example.png)

## 🚀 Uso
1. Clona este repo:
   ```bash
   git clone git@github.com:TuUsuario/rofi-config.git



## 📜 Licencia assets
- Archivos de configuración: MIT  
- Imagen incluida (hecha en Inkscape): CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)


## 📜 Nota
Este repositorio contiene únicamente mi configuración personal para Rofi.  
Rofi es un proyecto independiente, distribuido bajo la licencia GPL-3.0.  
Para más información sobre Rofi: [https://github.com/davatorium/rofi](https://github.com/davatorium/rofi)





# Neovim Config

Personal Neovim configuration optimized for **web development, TypeScript, React/Next.js, and Lua**.  
Includes modern plugins for **LSP, completion, snippets, telescope, UI enhancements, and Git integration**.

---

## ✨ Features

- **LSP** via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (preconfigured for TypeScript).
- **Completion** with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), Copilot, buffer, path, cmdline sources.
- **Snippets** powered by [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- **UI/UX**:  
  - [tokyonight](https://github.com/folke/tokyonight.nvim) colorscheme  
  - [lualine](https://github.com/nvim-lualine/lualine.nvim) statusline  
  - [alpha-nvim](https://github.com/goolord/alpha-nvim) dashboard  
  - [nvim-notify](https://github.com/rcarriga/nvim-notify) notifications  
  - [noice.nvim](https://github.com/folke/noice.nvim) better cmdline & UI
- **File navigation** with [NERDTree](https://github.com/preservim/nerdtree) and [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- **Git integration** via [vim-gitbranch](https://github.com/itchyny/vim-gitbranch).
- **React/Next.js abbreviations** for faster coding (e.g. `usee-` → `useEffect(() => {}, [])`).
- **Indent guides** with [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).

---

## 📦 Requirements

- **Neovim** >= 0.8  
- **Node.js** (for Copilot and some plugins)  
- **Yarn** (for React snippets plugin build step)  
- **ripgrep** (for Telescope live grep)  
- **zsh** (set as default shell in config)

---

## 🚀 Installation

1. Install [vim-plug](https://github.com/junegunn/vim-plug) if not already installed.
2. Clone this repo into your Neovim config folder:
   ```sh
   git clone https://github.com/your-username/nvim-config ~/.config/nvim

