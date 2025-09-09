<h1 align="center">
   <img src="./.github/assets/logo/nixos-logo.png  " width="100px" />
   <br>
      w3max's Flakes
   <br>
      <img src="./.github/assets/pallet/pallet-0.png" width="600px" /> <br>

    <p></p>
    <div align="center">
       <a href="https://github.com/w3max/nixos-config/stargazers">
          <img src="https://img.shields.io/github/stars/w3max/nixos-config?color=FABD2F&labelColor=282828&style=for-the-badge&logo=starship&logoColor=FABD2F">
       </a>
       <a href="https://github.com/w3max/nixos-config/">
          <img src="https://img.shields.io/github/repo-size/w3max/nixos-config?color=B16286&labelColor=282828&style=for-the-badge&logo=github&logoColor=B16286">
       </a>
       <a = href="https://nixos.org">
          <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=282828&logo=NixOS&logoColor=458588&color=458588">
       </a>
       <a href="https://github.com/w3max/nixos-config/blob/main/LICENSE">
          <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=282828&colorB=98971A&logo=unlicense&logoColor=98971A&"/>
       </a>
    </div>
    <br>

</div>
</h1>

### 🖼️ Gallery

<p align="center">
   <img src="./.github/assets/screenshots/1.png" style="margin-bottom: 15px;"/> <br>
   <img src="./.github/assets/screenshots/2.png" style="margin-bottom: 15px;"/> <br>
   <img src="./.github/assets/screenshots/3.png" style="margin-bottom: 15px;"/> <br>
   <img src="./.github/assets/screenshots/4.png" style="margin-bottom: 15px;"/> <br>
   <img src="./.github/assets/screenshots/5.png" style="margin-bottom: 15px;"/> <br>
   <img src="./.github/assets/screenshots/hyprlock.png" style="margin-bottom: 15px;" /> <br>
   Screenshots last updated <b>2025-01-05</b>
</p>

# 🗃️ Overview

## ⚡ Recent Major Improvements

🎉 **Latest Updates**: This configuration has been significantly enhanced with enterprise-grade features:

### 🔐 **Security & Secret Management**
- **✅ Clan-native secret management** with age encryption
- **✅ Per-machine access control** for all secrets
- **✅ Automated secure deployment** via Nix store
- **✅ Admin keypair generated** and all machines configured

### 🛠️ **Development Excellence**
- **✅ Comprehensive pre-commit hooks** for code quality
- **✅ All shell scripts security-hardened** (20+ scripts fixed)
- **✅ Fast linting workflow** (no more slow `nix flake check`)
- **✅ Automated formatting and validation**

### 📚 **Complete Documentation**
- **✅ 6 comprehensive guides** covering all aspects
- **✅ Quick-start workflows** for common operations
- **✅ Security best practices** and troubleshooting
- **✅ Developer contributor guidelines**

## 🏗️ Core Infrastructure Features

This configuration supports advanced deployment and infrastructure management:

### 🏗️ **Clan Framework Integration**

- **Multi-machine management**: Easily deploy and manage multiple NixOS systems
- **Remote deployment**: Deploy configurations to remote machines over SSH
- **Service orchestration**: Coordinate services across multiple machines
- **Infrastructure as code**: Manage your entire infrastructure declaratively

### 💾 **Declarative Disk Management (Disko)**

- **Automated partitioning**: Define disk layouts in Nix configuration
- **Reproducible storage**: Consistent disk setup across machines
- **ZFS/Btrfs support**: Advanced filesystems with snapshots and compression
- **RAID configurations**: Declarative software RAID setup

### 🚀 **Remote Installation (nixos-anywhere)**

- **Over-the-air installs**: Install NixOS remotely via SSH
- **Rescue system**: Transform any Linux system into NixOS
- **Zero-touch deployment**: Automated installation without physical access
- **Custom disk layouts**: Apply disko configurations during remote installs

### 🔐 **Enterprise-Grade Security**

- **Age-encrypted secrets**: Modern cryptography with per-machine access control
- **Clan secret management**: Native integration with infrastructure management
- **Secure deployment**: Secrets deployed via Nix store with proper permissions
- **Access control**: User and machine-level permissions for all secrets
- **Key rotation**: Easy secret updates and key management

### 🛠️ **Development Excellence**

- **Pre-commit hooks**: Comprehensive code quality enforcement
- **Shell script security**: All scripts pass shellcheck with security fixes
- **Fast linting workflow**: Efficient development with targeted validation
- **Code consistency**: Automated Nix formatting and style enforcement
- **Git integration**: Automatic quality checks on every commit

### 🎯 **Semantic Module Organization**

- **Purpose-based grouping**: Modules organized by function (common, desktop,
  development, gaming)
- **Machine-specific configs**: Host-specific settings (monitor layouts,
  hardware optimizations)
- **Flexible subscription**: Machines can subscribe to different feature sets
- **Clean separation**: Clear distinction between system and user configurations

## 📚 Layout

- [flake.nix](flake.nix) base of the configuration with
  clan/disko/nixos-anywhere inputs
- [nix/](nix/) 🔧 flake organization using flake-parts
  - [machines.nix](nix/machines.nix) 🏗️ all machine definitions with module
    subscriptions
  - [clan.nix](nix/clan.nix) 👥 clan framework configuration and machine
    metadata
- [machines](machines) 🌳 per-host configurations that contain machine specific
  settings
  - [desktop](machines/desktop/) 🖥️ Desktop specific configuration + hyprland
    monitors
  - [laptop](machines/laptop/) 💻 Laptop specific configuration + power
    management
  - [vm](machines/vm/) 🗄️ VM specific configuration
  - [w3max-workstation](machines/w3max-workstation/) 🎮 High-end AMD gaming/dev
    workstation with disko config
- [modules](modules) 🍱 semantic modularized NixOS configurations
  - [common.nix](modules/common.nix) ⚙️ Essential system configuration (all
    machines)
  - [desktop.nix](modules/desktop.nix) 🖥️ Desktop environment configuration
  - [development.nix](modules/development.nix) 👨‍💻 Development tools and
    virtualization
  - [gaming.nix](modules/gaming.nix) 🎮 Gaming configuration (Steam, etc.)
  - [home-*.nix](modules/) 🏠 Home-manager module groups
  - [core/](modules/core/) ⚙️ Individual NixOS modules
  - [home/](modules/home/) 🏠 Individual home-manager modules
- [wallpapers](wallpapers/) 🌄 wallpapers collection
- [scripts/](scripts/) 🛠️ deployment and installation scripts
  - [install.sh](scripts/install.sh) 📦 traditional installation script
  - [deploy.sh](scripts/deploy.sh) 🚀 remote deployment script with
    nixos-anywhere

### 🏠 Machine Configurations

| Machine               | System Modules                          | Home Modules          | Description                                |
| --------------------- | --------------------------------------- | --------------------- | ------------------------------------------ |
| **desktop**           | common + desktop + development + gaming | all home modules      | Full-featured desktop setup                |
| **laptop**            | common + desktop + development          | desktop + development | Mobile development machine                 |
| **vm**                | common + desktop                        | basic desktop         | Minimal testing environment                |
| **w3max-workstation** | common + desktop + development + gaming | all home modules      | High-end AMD gaming/dev station with disko |

## 📓 Components

|                             |                                  NixOS + Hyprland                                   |
| --------------------------- | :---------------------------------------------------------------------------------: |
| **Window Manager**          |                                [Hyprland][Hyprland]                                 |
| **Bar**                     |                                  [Waybar][Waybar]                                   |
| **Application Launcher**    |                                    [rofi][rofi]                                     |
| **Notification Daemon**     |                                  [swaync][swaync]                                   |
| **Terminal Emulator**       |                                 [Ghostty][Ghostty]                                  |
| **Shell**                   |                     [zsh][zsh] + [powerlevel10k][powerlevel10k]                     |
| **Text Editor**             |                       [VSCodium][VSCodium] + [Neovim][Neovim]                       |
| **network management tool** | [NetworkManager][NetworkManager] + [network-manager-applet][network-manager-applet] |
| **System resource monitor** |                                    [Btop][Btop]                                     |
| **File Manager**            |                             [nemo][nemo] + [yazi][yazi]                             |
| **Fonts**                   |                              [Maple Mono][Maple Mono]                               |
| **Color Scheme**            |                            [Gruvbox Dark Hard][Gruvbox]                             |
| **GTK theme**               |                       [Colloid gtk theme][Colloid gtk theme]                        |
| **Cursor**                  |                       [Bibata-Modern-Ice][Bibata-Modern-Ice]                        |
| **Icons**                   |                            [Papirus-Dark][Papirus-Dark]                             |
| **Lockscreen**              |             [Hyprlock][Hyprlock] + [Swaylock-effects][Swaylock-effects]             |
| **Image Viewer**            |                                     [imv][imv]                                      |
| **Media Player**            |                                     [mpv][mpv]                                      |
| **Music Player**            |                               [audacious][audacious]                                |
| **Screenshot Software**     |                               [grimblast][grimblast]                                |
| **Screen Recording**        |                       [wf-recorder][wf-recorder] + [OBS][OBS]                       |
| **Clipboard**               |                         [wl-clip-persist][wl-clip-persist]                          |
| **Color Picker**            |                              [hyprpicker][hyprpicker]                               |

## 📝 Shell aliases

<details>
<summary>
Utils (EXPAND)
</summary>

- `c` $\rightarrow$ `clear`
- `cd` $\rightarrow$ `z`
- `tt` $\rightarrow$ `gtrash put`
- `vim` $\rightarrow$ `nvim`
- `cat` $\rightarrow$ `bat`
- `nano` $\rightarrow$ `micro`
- `code` $\rightarrow$ `codium`
- `diff` $\rightarrow$ `delta --diff-so-fancy --side-by-side`
- `less` $\rightarrow$ `bat`
- `y` $\rightarrow$ `yazi`
- `py` $\rightarrow$ `python`
- `ipy` $\rightarrow$ `ipython`
- `icat` $\rightarrow$ `kitten icat`
- `dsize` $\rightarrow$ `du -hs`
- `pdf` $\rightarrow$ `tdf`
- `open` $\rightarrow$ `xdg-open`
- `space` $\rightarrow$ `ncdu`
- `man` $\rightarrow$ `BAT_THEME='default' batman`
- `l` $\rightarrow$ `eza --icons  -a --group-directories-first -1`
- `ll` $\rightarrow$
  `eza --icons  -a --group-directories-first -1 --no-user --long`
- `tree` $\rightarrow$ `eza --icons --tree --group-directories-first`

</details>

<details>
<summary>
Nixos (EXPAND)
</summary>

- `cdnix` $\rightarrow$ `cd ~/nixos-config && codium ~/nixos-config`
- `ns` $\rightarrow$ `nom-shell --run zsh`
- `nix-test` $\rightarrow$ `nh os test`
- `nix-switch` $\rightarrow$ `nh os switch`
- `nix-update` $\rightarrow$ `nh os switch --update`
- `nix-clean` $\rightarrow$ `nh clean all --keep 5`
- `nix-search` $\rightarrow$ `nh search`

</details>

<details>
<summary>
Git (EXPAND)
</summary>

- `g` $\rightarrow$ `lazygit`
- `gf` $\rightarrow$ `onefetch --number-of-file-churns 0 --no-color-palette`
- `ga` $\rightarrow$ `git add`
- `gaa` $\rightarrow$ `git add --all`
- `gs` $\rightarrow$ `git status`
- `gb` $\rightarrow$ `git branch`
- `gm` $\rightarrow$ `git merge`
- `gd` $\rightarrow$ `git diff`
- `gpl` $\rightarrow$ `git pull`
- `gplo` $\rightarrow$ `git pull origin`
- `gps` $\rightarrow$ `git push`
- `gpso` $\rightarrow$ `git push origin`
- `gpst` $\rightarrow$ `git push --follow-tags`
- `gcl` $\rightarrow$ `git clone`
- `gc` $\rightarrow$ `git commit`
- `gcm` $\rightarrow$ `git commit -m`
- `gcma` $\rightarrow$ `git add --all && git commit -m`
- `gtag` $\rightarrow$ `git tag -ma`
- `gch` $\rightarrow$ `git checkout`
- `gchb` $\rightarrow$ `git checkout -b`
- `glog` $\rightarrow$ `git log --oneline --decorate --graph`
- `glol` $\rightarrow$
  `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'`
- `glola` $\rightarrow$
  `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all`
- `glols` $\rightarrow$
  `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat`

</details>

## 🛠️ Scripts

All the scripts are in `modules/home/scripts/scripts/` and are exported as
packages in `modules/home/scripts/default.nix`

<details>
<summary>
extract.sh
</summary>

**Description:** This script extract `tar.gz` archives in the current directory.

**Usage:** `extract <archive_file>`

</details>

<details>
<summary>
compress.sh
</summary>

**Description:** This script compress a file or a folder into a `tar.gz`
archives which is created in the current directory with the name of the chosen
file or folder.

**Usage:** `compress <file>` or `compress <folder>`

</details>

<details>
<summary>
toggle_blur.sh
</summary>

**Description:** This script toggles the Hyprland blur effect. If the blur is
currently enabled, it will be disabled, and if it's disabled, it will be turned
on.

**Usage:** `toggle_blur`

</details>

<details>
<summary>
toggle_opacity.sh
</summary>

**Description:** This script toggles the Hyprland opacity effect. If the
opacity is currently set to 0.90, it will be set to 1, and if it's set to 1, it
will be set to 0.90.

**Usage:** `toggle_opacity`

</details>

<details>
<summary>
maxfetch.sh
</summary>

**Description:** This script is a modified version of the
[jobcmax/maxfetch][maxfetch] script.

**Usage:** `maxfetch`

</details>

<details>
<summary>
music.sh
</summary>

**Description:** This script is for managing Audacious (music player). If
Audacious is currently running, it will be killed (stopping the music);
otherwise, it will start Audacious in the 8th workspace and resume the music.

**Usage:** `music`

</details>

<details>
<summary>
runbg.sh
</summary>

**Description:** This script runs a provided command along with its arguments
and detaches it from the terminal. Handy for launching apps from the command
line without blocking it.

**Usage:** `runbg <command> <arg1> <arg2> <...>`

</details>

## ⌨️ Keybinds

View all keybinds by pressing `$mainMod F1` and wallpaper picker by pressing
`$mainMod w`. By default `$mainMod` is the `SUPER` key.

<details>
<summary>
Keybindings
</summary>

##### show keybinds list

- `$mainMod, F1, exec, show-keybinds`

##### keybindings

- `$mainMod, Return, exec, wezterm start --always-new-process`
- `ALT, Return, exec, [float; center] wezterm start --always-new-process`
- `$mainMod SHIFT, Return, exec, [fullscreen] wezterm start --always-new-process`
- `$mainMod, B, exec, hyprctl dispatch exec '[workspace 1 silent] floorp'`
- `$mainMod, Q, killactive,`
- `$mainMod, F, fullscreen, 0`
- `$mainMod SHIFT, F, fullscreen, 1`
- `$mainMod, Space, togglefloating,`
- `$mainMod, D, exec, rofi -show drun`
- `$mainMod SHIFT, D, exec, hyprctl dispatch exec '[workspace 4 silent] discord --enable-features=UseOzonePlatform --ozone-platform=wayland'`
- `$mainMod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'`
- `$mainMod, Escape, exec, swaylock`
- `ALT, Escape, exec, hyprlock`
- `$mainMod SHIFT, Escape, exec, power-menu`
- `$mainMod, P, pseudo,`
- `$mainMod, J, togglesplit,`
- `$mainMod, T, exec, toggle_opacity`
- `$mainMod, E, exec, nemo`
- `$mainMod SHIFT, B, exec, toggle_waybar`
- `$mainMod, C ,exec, hyprpicker -a`
- `$mainMod, W,exec, wallpaper-picker`
- `$mainMod, N, exec, swaync-client -t -sw`
- `$mainMod SHIFT, W, exec, vm-start`

##### screenshot

- `$mainMod, Print, exec, grimblast --notify --cursor --freeze save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png`
- `,Print, exec, grimblast --notify --cursor --freeze copy area`

##### switch focus

- `$mainMod, left, movefocus, l`
- `$mainMod, right, movefocus, r`
- `$mainMod, up, movefocus, u`
- `$mainMod, down, movefocus, d`

##### switch workspace

- `$mainMod, 1, workspace, 1`
- `$mainMod, 2, workspace, 2`
- `$mainMod, 3, workspace, 3`
- `$mainMod, 4, workspace, 4`
- `$mainMod, 5, workspace, 5`
- `$mainMod, 6, workspace, 6`
- `$mainMod, 7, workspace, 7`
- `$mainMod, 8, workspace, 8`
- `$mainMod, 9, workspace, 9`
- `$mainMod, 0, workspace, 10`

##### same as above, but switch to the workspace

- `$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent`
- `$mainMod SHIFT, 2, movetoworkspacesilent, 2"`
- `$mainMod SHIFT, 3, movetoworkspacesilent, 3"`
- `$mainMod SHIFT, 4, movetoworkspacesilent, 4"`
- `$mainMod SHIFT, 5, movetoworkspacesilent, 5"`
- `$mainMod SHIFT, 6, movetoworkspacesilent, 6"`
- `$mainMod SHIFT, 7, movetoworkspacesilent, 7"`
- `$mainMod SHIFT, 8, movetoworkspacesilent, 8"`
- `$mainMod SHIFT, 9, movetoworkspacesilent, 9"`
- `$mainMod SHIFT, 0, movetoworkspacesilent, 10"`
- `$mainMod CTRL, c, movetoworkspace, empty"`

##### window control

- `$mainMod SHIFT, left, movewindow, l`
- `$mainMod SHIFT, right, movewindow, r`
- `$mainMod SHIFT, up, movewindow, u`
- `$mainMod SHIFT, down, movewindow, d`
- `$mainMod CTRL, left, resizeactive, -80 0`
- `$mainMod CTRL, right, resizeactive, 80 0`
- `$mainMod CTRL, up, resizeactive, 0 -80`
- `$mainMod CTRL, down, resizeactive, 0 80`
- `$mainMod ALT, left, moveactive,  -80 0`
- `$mainMod ALT, right, moveactive, 80 0`
- `$mainMod ALT, up, moveactive, 0 -80`
- `$mainMod ALT, down, moveactive, 0 80`

##### media and volume controls

- `,XF86AudioRaiseVolume,exec, pamixer -i 2`
- `,XF86AudioLowerVolume,exec, pamixer -d 2`
- `,XF86AudioMute,exec, pamixer -t`
- `,XF86AudioPlay,exec, playerctl play-pause`
- `,XF86AudioNext,exec, playerctl next`
- `,XF86AudioPrev,exec, playerctl previous`
- `,XF86AudioStop, exec, playerctl stop`
- `$mainMod, mouse_down, workspace, e-1`
- `$mainMod, mouse_up, workspace, e+1`

##### laptop brigthness

- `,XF86MonBrightnessUp, exec, brightnessctl set 5%+`
- `,XF86MonBrightnessDown, exec, brightnessctl set 5%-`
- `$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+`
- `$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-`

##### clipboard manager

- `$mainMod, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;}' | cliphist decode | wl-copy`

</details>

# 🚀 Installation

## 🎯 Which Installation Method to Choose?

This configuration offers **two complementary deployment approaches**:

| Use Case                 | Tool                                 | Best For                                                                                                          |
| ------------------------ | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **Initial Installation** | `scripts/deploy.sh` (nixos-anywhere) | • Fresh machine setup<br>• One-off installations<br>• Hardware detection needed<br>• Maximum control over process |
| **Ongoing Management**   | `clan machines` commands             | • Configuration updates<br>• Multi-machine coordination<br>• Service orchestration<br>• Infrastructure operations |

### 🏁 Quick Decision Guide

```
New machine? → Use deploy.sh
Existing setup? → Use clan commands
Multiple machines? → deploy.sh first, then clan
```

---

## 📦 Traditional Installation

> [!CAUTION]
> Applying custom configurations, especially those related to your operating
> system, can have unexpected consequences and may interfere with your system's
> normal behavior. While I have tested these configurations on my own setup,
> there is no guarantee that they will work flawlessly for you. **I am not
> responsible for any issues that may arise from using this configuration.**

> [!NOTE]
> It is highly recommended to review the configuration contents and make
> necessary modifications to customize it to your needs before attempting the
> installation.

#### 1. **Install NixOs**

First install nixos using any
[graphical ISO image](https://nixos.org/download.html#nixos-iso).

> [!NOTE]
> Only been tested using the Gnome graphical installer and choosing the
> `No desktop` option durring instalation.

#### 2. **Clone the repo**

```bash
nix-shell -p git
git clone https://github.com/w3max/nixos-config
cd nixos-config
```

#### 3. **Install script**

> [!CAUTION]
> For some computers, the default rebuild command might get stuck due to CPU
> cores running out of RAM. To fix that modify the install script line:
> `sudo nixos-rebuild switch --flake .#${HOST}` to
> `sudo nixos-rebuild switch --cores <less than your max number of cores> --flake .#${HOST}`

> [!TIP]
> As it is better to know what a script does before running it, you are advised
> to read it or at least see the
> [Install script walkthrough](#Install-script-walkthrough) section before
> execution.

Execute and follow the installation script :

```bash
./scripts/install.sh
```

#### 4. **Reboot**

After rebooting, the config should be applied, you'll be greeted by hyprlock
prompting for your password.

## 🚀 Remote Installation with nixos-anywhere

For remote installations on fresh machines or VMs:

#### 1. **Prepare target machine**

- Boot target machine with any Linux live system
- Ensure SSH access to the target machine
- Target machine should have internet connectivity

#### 2. **Configure disk layout (optional)**

- Edit or create `machines/your-machine/disk-config.nix`
- See `machines/w3max-workstation/disk-config.nix` for a comprehensive example
- Supports complex setups: multiple drives, Btrfs subvolumes, ZFS, RAID

#### 3. **Deploy remotely**

**Easy deployment with script (recommended):**

```bash
# Use the automated deploy script
./scripts/deploy.sh 192.168.1.100
```

**Manual deployment:**

```bash
# Install to a remote machine
nix run github:nix-community/nixos-anywhere -- \
  --flake .#your-machine-name \
  root@target-machine-ip

# Example: Install w3max-workstation
nix run github:nix-community/nixos-anywhere -- \
  --flake .#w3max-workstation \
  root@192.168.1.100
```

This will:

- Partition disks according to your disko configuration
- Install NixOS with your complete configuration
- Automatically reboot into your configured system

## 🏗️ Clan Management (Ongoing Operations)

**Use Clan for managing existing systems and multi-machine coordination.**

### 🔍 Discovery and Status

```bash
# List all configured machines
nix run github:clan-lol/clan-core -- machines list

# Check machine status
nix run github:clan-lol/clan-core -- machines status

# Show machine details
nix run github:clan-lol/clan-core -- machines show w3max-workstation
```

### 🚀 Deployment Operations

```bash
# Deploy configuration updates to specific machine
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

# Deploy to all machines
nix run github:clan-lol/clan-core -- machines deploy

# Deploy with specific flake update
nix run github:clan-lol/clan-core -- machines deploy --update-all
```

### 🌐 Multi-Machine Coordination

```bash
# Set up machine mesh networking
nix run github:clan-lol/clan-core -- machines add-peer desktop laptop

# Coordinate services across machines
nix run github:clan-lol/clan-core -- services start backup-sync

# Monitor cluster status
nix run github:clan-lol/clan-core -- machines health-check
```

### 📋 Available Machines

| Machine             | Description                     | Tags                     | Best Managed With   |
| ------------------- | ------------------------------- | ------------------------ | ------------------- |
| `desktop`           | Full-featured desktop setup     | desktop                  | Clan (post-install) |
| `laptop`            | Mobile development machine      | laptop, mobile           | Clan (post-install) |
| `vm`                | Minimal testing environment     | vm, test                 | Both tools          |
| `w3max-workstation` | High-end AMD gaming/dev station | desktop, gaming, storage | deploy.sh → clan    |

### 🔄 Migration from nixos-anywhere to Clan

After initial deployment with `deploy.sh`, transition to Clan management:

```bash
# 1. Verify machine is accessible
nix run github:clan-lol/clan-core -- machines list

# 2. Test configuration deployment
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --dry-run

# 3. Switch to Clan management
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

# 4. Enable additional services as needed
nix run github:clan-lol/clan-core -- services enable zerotier
```

---

## 📚 Documentation

### Infrastructure Management
- **[Clan Workflows Guide](docs/CLAN-WORKFLOWS.md)** - Daily operations and advanced Clan workflows
- **[Migration Guide](docs/MIGRATION-GUIDE.md)** - Transitioning from nixos-anywhere to Clan management
- **[Clan Management](docs/CLAN-MANAGEMENT.md)** - Complete Clan framework reference

### Security & Development
- **[Security Guide](docs/SECURITY.md)** - Secret management with age encryption
- **[Development Workflow](docs/DEVELOPMENT.md)** - Pre-commit hooks, linting, and code quality
- **[Linting Reference](docs/LINTING.md)** - Fast linting commands and hook configuration

---

#### 5. **Manual config**

Even though I use home manager, there is still a little bit of manual
configuration to do:

- Configure the browser (for now, all browser configuration is done manually).
- Change the git account information in `./modules/home/git.nix`

```nix
programs.git = {
   ...
   userName = "w3max";
   userEmail = "67cyril6767@gmail.com";
   ...
};
```

## Install script walkthrough

A brief walkthrough of what the install script does.

#### 1. **Get username**

You will receive a prompt to enter your username, with a confirmation check.

#### 2. **Set username**

The script will replace all occurancies of the default usename
`CURRENT_USERNAME` by the given one stored in `$username`

#### 3. Create basic directories

The following directories will be created:

- `~/Music`
- `~/Documents`
- `~/Pictures/wallpapers/others`

#### 4. Copy the wallpapers

Then the wallpapers will be copied into `~/Pictures/wallpapers/others` which is
the folder in which the `wallpaper-picker.sh` script will be looking for them.

#### 5. Get the hardware configuration

It will also automatically copy the hardware configuration from
`/etc/nixos/hardware-configuration.nix` to
`./machines/${host}/hardware-configuration.nix` so that the hardware
configuration used is yours and not the default one.

#### 6. Choose a machine (desktop / laptop)

Now you will need to choose the machine you want. It depend on whether you are
using a desktop or laptop (or a VM altho it can be really buggy).

#### 7. Build the system

Lastly, it will build the system, which includes both the flake config and
home-manager config.

# 👥 Credits

- Forked From
  - [Frost-Phoenix/nixos-config](https://github.com/nomadics9/NixOS-Flake): This
    is where I started my NixOS / Hyprland journey.

<!-- end of page, send back to the top -->

<div align="right">
  <a href="#readme">Back to the Top</a>
</div>

<!-- Links -->

[Hyprland]: https://github.com/hyprwm/Hyprland
[Ghostty]: https://ghostty.org/
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[rofi]: https://github.com/lbonn/rofi
[Btop]: https://github.com/aristocratos/btop
[nemo]: https://github.com/linuxmint/nemo/
[yazi]: https://github.com/sxyazi/yazi
[zsh]: https://ohmyz.sh/
[Swaylock-effects]: https://github.com/mortie/swaylock-effects
[Hyprlock]: https://github.com/hyprwm/hyprlock
[audacious]: https://audacious-media-player.org/
[mpv]: https://github.com/mpv-player/mpv
[VSCodium]: https://vscodium.com/
[Neovim]: https://github.com/neovim/neovim
[grimblast]: https://github.com/hyprwm/contrib
[imv]: https://sr.ht/~exec64/imv/
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[Maple Mono]: https://github.com/subframe7536/maple-font
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clip-persist]: https://github.com/Linus789/wl-clip-persist
[wf-recorder]: https://github.com/ammen99/wf-recorder
[hyprpicker]: https://github.com/hyprwm/hyprpicker
[Gruvbox]: https://github.com/morhetz/gruvbox
[Papirus-Dark]: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[Bibata-Modern-Ice]: https://www.gnome-look.org/p/1197198
[maxfetch]: https://github.com/jobcmax/maxfetch
[Colloid gtk theme]: https://github.com/vinceliuice/Colloid-gtk-theme
[OBS]: https://obsproject.com/
