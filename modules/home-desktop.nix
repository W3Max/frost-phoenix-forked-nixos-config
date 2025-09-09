# Desktop home-manager configuration
{ ... }: {
  imports = [
    # Home desktop modules
    ./home/browser.nix
    ./home/cava.nix
    ./home/ghostty.nix
    ./home/gnome.nix
    ./home/gtk.nix
    ./home/hyprland
    ./home/nemo.nix
    ./home/rofi.nix
    ./home/swaylock.nix
    ./home/swayosd.nix
    ./home/swaync/swaync.nix
    ./home/waybar
    ./home/waypaper.nix
    ./home/xdg-mimes.nix

    # Creative tools
    ./home/audacious/audacious.nix
    ./home/obsidian.nix
  ];
}
