# Desktop-specific Hyprland monitor configuration
{ ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # Configure your laptop display here
      # Example: "eDP-1,1920x1080@60.00Hz,0x0,1"
      ",preferred,auto,1" # Auto-detect display
    ];
  };
}
