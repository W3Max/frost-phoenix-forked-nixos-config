{ inputs, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    # preferences = {
    #   "widget.use-xdg-desktop-portal.file-picker" = 1;
    # };
  };

  # home.packages = (
  #   with pkgs;
  #   [
  #     inputs.zen-browser.packages."${system}".default
  #   ]
  # );
}
