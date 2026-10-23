# Arcane Shell

A sleek, atmospheric desktop shell built for Linux and tuned for Hyprland. Arcane Shell aims to blend fluid UX, immersive visuals, and minimal friction into a modern desktop experience.

> Crafted for the aesthetic-minded, the productive, and the curious.

## ✨ Vision

Arcane Shell is a custom shell experience designed to feel magical without sacrificing usability. The focus is on:

- smooth, modern desktop interactions
- Hyprland-first workflow
- elegant wallpaper and UI control
- compact, highly customizable shell behavior
- a cyberpunk / arcane aesthetic with clean lines and ambient motion

## 🧩 Project Direction

This project is intended to grow into a fully customized shell for Linux desktops, with a strong emphasis on:

- Hyprland integration
- Wayland-native behavior
- tasteful visual polish
- configurable controls and layouts
- a living, customizable desktop environment

## 🖥️ Requirements

Arcane Shell is designed primarily for:

- Arch Linux
- Hyprland
- Quickshell
- Wayland session

You should already have a working Hyprland setup before using this shell.

## ⚙️ Setup on Arch Linux + Hyprland

### 1) Install Quickshell

On Arch Linux, install Quickshell using your preferred AUR helper:

```bash
paru -S quickshell
```

If you use another AUR helper, replace `paru` accordingly.

### 2) Make sure `qs` is available in PATH

After installation, verify the binary is available:

```bash
qs --help
```

If the command is not found, make sure the Quickshell binary is in your PATH or launch it from the installed location.

### 3) Add the wallpaper toggle keybind to Hyprland

Edit your Hyprland configuration file and add this binding so the wallpaper picker works correctly:

```lua
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs ipc call wallpaper toggle"))
```

This is the critical shortcut for toggling the wallpaper picker / wallpaper control from the shell.

Example snippet:

```lua
-- ~/.config/hypr/hyprland.conf
$mainMod = SUPER

bind = $mainMod, W, exec, qs ipc call wallpaper toggle
```

If your config is using Lua-generated Hyprland config logic, the equivalent form is:

```lua
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs ipc call wallpaper toggle"))
```

## 🚀 Quick Start

1. Clone the repository
2. Place the shell files into your Quickshell configuration structure
3. Launch Hyprland
4. Use the keybind to toggle wallpaper controls and begin customizing the shell

Example:

```bash
git clone https://github.com/tsukuyomi-0001/arcane-shell.git
cd arcane-shell
```

## 🧠 Features Planned

- customizable desktop shell layout
- animated wallpaper interactions
- minimal but expressive widgets
- Hyprland-native hotkeys
- aesthetic visual style with arcane-inspired theming
- quick-access controls for media, workspace, and status elements

## 🗂️ Project Structure

```text
arcane-shell/
├── README.md
├── config/
├── shell/
├── assets/
├── scripts/
└── themes/
```

This structure is subject to evolve as the shell develops.

## 🎨 Design Language

The goal is to create a shell that feels:

- immersive
- polished
- dynamic
- calm but energetic
- futuristic and atmospheric

Think “arcane elegance meets functional desktop utility.”

## 🛠️ Contribution

Contributions are welcome as this project evolves.

If you'd like to contribute:

- improve shell behavior
- refine visual themes
- add better Hyprland integration
- expand wallpaper and panel features

Open an issue or open a pull request.

## 📌 Notes

Arcane Shell is in active development. The visual and behavior direction may evolve as the project matures, but the core goal remains the same:

build a beautiful, usable, immersive shell for Linux users who want their desktop to feel alive.

---

Made for the Arcane desktop dream. Built for Hyprland. Designed to feel alive.
