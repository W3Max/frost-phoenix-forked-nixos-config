# Desktop environment configuration
{ ... }: {
  imports = [
    # Core desktop modules
    ./core/xserver.nix
    ./core/wayland.nix
    ./core/pipewire.nix
    ./core/services.nix
    ./core/flatpak.nix
  ];
}
