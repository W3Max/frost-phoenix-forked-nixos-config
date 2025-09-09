# nix/clan.nix
# Clan configuration for multi-machine management
{ ... }: {
  # Clan configuration goes in flake outputs
  flake = {
    # Default secrets configuration
    secrets.age.plugins = [ ];

    # Clan inventory for machine management
    clanInternals = {
      # Inventory class for clan operations
      inventoryClass = {
        # Basic inventory structure
        inventory = {
          machines = {
            desktop = {
              description = "Main desktop system";
              tags = [ "desktop" ];
              targetHost = "root@desktop.local";
            };

            w3max-workstation = {
              description =
                "AMD Ryzen 7800X3D + RX 7900 XTX Gaming/Dev Station";
              tags = [ "desktop" "gaming" "development" "storage-server" ];
              targetHost = "root@w3max-workstation.local";
            };
          };

          # Service instances
          instances = {
            syncthing = {
              roles.peer.tags.all = { };
              roles.peer.settings = {
                folders = {
                  w3max-obsidian = {
                    path = "/home/w3max/Documents/Obsidian/w3max-obsidian";
                    id = "6c44y-t3joa";
                  };
                };

                extraDevices = {
                  "Maxime-s-S22-Ultra" = {
                    id =
                      "H64VV3J-SX54IMR-VUU5BGA-5GF62GC-74PNXOS-DPC37FC-5KUGUU5-DHXR2QD";
                    autoAcceptFolders = true;
                    allowedNetwork = "192.168.1.0/24";
                    addresses = [ "tcp://192.168.1.159:51820" ];
                  };
                  "raspberrypi" = {
                    id =
                      "2IXC2MO-OX242ZJ-BR67J65-7PFGAE2-6GAXEYV-LYJOLHS-2WG3QYR-5GUC5AD";
                    allowedNetwork = "192.168.1.0/24";
                    autoAcceptFolders = true;
                    addresses = [ "tcp://192.168.1.109:51820" ];
                  };
                };

                # Only sync on LAN
                options.globalAnnounceEnabled = false;
              };
            };
          };

          # Clan meta information
          meta = {
            name = "W3Max-Clan";
            description = "Personal computing infrastructure";
          };

          # Global tags
          tags = [ "nixos" "hyprland" "personal" ];
        };
      };
    };
  };
}
