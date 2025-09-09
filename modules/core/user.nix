{ config, pkgs, inputs, username, host, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      imports = [
        ./../home-common.nix
        (./../../machines
          + "/${host}/hyprland.nix") # Host-specific hyprland config
      ] ++ (
        # Import appropriate module groups based on host type
        if (host == "desktop") then [
          ./../home-desktop.nix
          ./../home-development.nix
          ./../home-gaming.nix
        ] else if (host == "w3max-workstation") then [
          ./../home-desktop.nix
          ./../home-development.nix
          ./../home-gaming.nix
        ] else
          [
            # other machines get basic desktop
            ./../home-desktop.nix
          ]);
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hm-backup";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.user-password.path;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
