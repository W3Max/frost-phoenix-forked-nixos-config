# W3Max Workstation-specific Hyprland monitor configuration
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # High-end gaming/dev station monitors
      # Configure based on your actual monitor setup
      # Example for high refresh gaming monitor:
      # "DP-1,3440x1440@144,0x0,1"
      # "HDMI-A-1,1920x1080@60,3440x0,1"
      ",preferred,auto,1"  # Auto-detect for now
    ];
  };
}