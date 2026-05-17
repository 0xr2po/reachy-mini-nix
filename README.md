# Reachy Mini – NixOS Development

This repository provides a fully reproducible development environment for the Reachy Mini Desktop App (Tauri + Rust + Node) using Nix Flakes.

It replaces local installations of Node.js, Rust, GTK, and related dependencies with a declarative and reproducible setup.

---

## Requirements

* Nix with Flakes enabled
* Linux system (optimized for NixOS)
* Git

### Enable Flakes (if not already enabled)

Add the following to your NixOS configuration:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Then rebuild your system:

```bash
sudo nixos-rebuild switch
```

---

## Enter Development Shell

From the project directory:

```bash
nix develop
```

This will provide a fully configured environment with:

* Node.js 24
* Yarn
* Rust toolchain (cargo, rustc, clippy, rustfmt)
* Tauri CLI support
* GTK / WebKit system libraries

---

## Project Structure

```text
.
├── flake.nix
└── README.md
```

The actual application repository is cloned separately.

---

## Clone the Application

```bash
git clone https://github.com/pollen-robotics/reachy-mini-desktop-app.git
cd reachy-mini-desktop-app
```

---

## Install Dependencies

```bash
yarn install
```

---

## Build Sidecar (Required Step)

Before building or running in production mode, build the sidecar binary:

```bash
yarn build:sidecar-linux
```

---

## Start Development Mode

```bash
yarn tauri:dev
```

---

## Included Packages (via Nix)

### Development Tools

* pkg-config
* git

### Node.js Environment

* nodejs_24
* yarn

### Rust / Tauri Toolchain

* rustc
* cargo
* clippy
* rustfmt
* cargo-tauri

### System Libraries

* GTK4
* WebKitGTK 4.1
* cairo, pango, glib
* openssl
* systemd (libudev)
* gdk-pixbuf
* librsvg

---

## Production Build Under Development (Not yet working)

```bash
yarn tauri:build
```

Optional platform-specific builds:

```bash
yarn tauri build --target x86_64-unknown-linux-gnu
```

---

## Why Nix?

This setup ensures:

* Reproducible development environments
* No global dependencies required
* Consistent builds across machines
* Elimination of "works on my machine" issues

---

## Exit the Shell

```bash
exit
```

---

## Garbage Collection (Optional)

Remove unused Nix store entries:

```bash
nix-collect-garbage -d
```

---

## Notes

This environment is designed specifically for:

* Tauri desktop applications
* Rust + Node hybrid projects
* Linux desktop development on Nix-based systems
