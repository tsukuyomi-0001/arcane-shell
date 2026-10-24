# Arcane Shell

Arcane Shell is a lightweight Quickshell-based desktop shell for Hyprland, designed to feel atmospheric, polished, and minimal. It combines a soft glassmorphism aesthetic with practical desktop controls for a modern, immersive Linux workflow.

> A focused desktop shell prototype for Wayland users who want a cleaner, more expressive top bar and utility layer.

## ✨ Current Features

- expandable glassy top panel with workspace indicator
- quick system status controls for Wi‑Fi and Bluetooth
- wallpaper browser for local image collections
- power actions menu with shutdown, restart, sleep, hibernate, and logout actions
- Quickshell IPC triggers for toggling overlay windows
- rounded, translucent styling with a cyberpunk / arcane visual language

## 🧩 Codebase Overview

The project is currently organized around a few QML files and a shared asset directory:

- `shell.qml` — main shell and panel layout
- `Wallpaper.qml` — wallpaper picker overlay
- `PowerMenu.qml` — power actions UI
- `res/` — icons, SVGs, and wallpaper-related resources

The current implementation uses Quickshell, Qt Quick, and QML, with a custom Hyprland-focused panel layout.

## 🖥️ Requirements

Arcane Shell is intended for:

- Arch Linux
- Hyprland
- Quickshell
- a Wayland session

## ⚙️ Setup

### 1) Install Quickshell

On Arch Linux, install Quickshell with your preferred AUR helper:

```bash
paru -S quickshell
```

If you use a different AUR helper, substitute it accordingly.

### 2) Ensure `qs` is in your PATH

```bash
qs --help
```

If it is not found, make sure the Quickshell binary is available in your PATH or invoke it from its install location.

### 3) Add the wallpaper toggle keybind

Add this binding to your Hyprland configuration:

```lua
bind = $mainMod, W, exec, qs ipc call wallpaper toggle
```

You can also add a power menu toggle if you want a direct shortcut:

```lua
bind = $mainMod, P, exec, qs ipc call power toggle
```

### 4) Prepare your wallpaper directory

The current wallpaper picker reads from a local folder:

```text
~/Pictures/Wallpaper
```

If your setup differs, update the `folder` path inside `Wallpaper.qml`.

### 5) Launch the shell

Place the QML files in a Quickshell config location or run the shell from your preferred Quickshell setup, then start Hyprland.

## 📁 Project Structure

```text
arcane-shell/
├── README.md
├── shell.qml
├── Wallpaper.qml
├── PowerMenu.qml
├── res/
│   ├── bluetooth.png
│   ├── wifi.png
│   ├── power.png
│   ├── restart.png
│   ├── sleep.png
│   ├── hibernate.png
│   ├── logout.png
│   ├── workspace.svg
│   └── ...
└── other assets as needed
```

## 🎨 Design Direction

The project aims to feel:

- immersive
- calm but expressive
- minimal but usable
- futuristic and atmospheric
- tailored to a modern Hyprland workflow

This is intentionally a shell prototype rather than a full desktop environment replacement. The focus is on a refined top bar, utility overlays, and an elegant desktop presence.

## 🛠️ Notes

Arcane Shell is still in active development. The interface and behavior may evolve as new widgets, interactions, and Hyprland integrations are added.

The core goal remains the same: build a beautiful, useful shell that feels alive without becoming overwhelming.

---

Made for the Arcane desktop dream. Built for Hyprland. Designed to feel alive.
