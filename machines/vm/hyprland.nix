# VM-specific Hyprland monitor configuration
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # VM display configuration
      ",preferred,auto,1"  # Auto-detect VM display
    ];
  };
}