# Desktop-specific Hyprland monitor configuration
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # Configure your desktop monitors here
      "HDMI-A-2,2560x1440@165.08Hz,0x0,1"
      "DP-1,1920x1080@60.00Hz,2560x0,1"
    ];
  };
}