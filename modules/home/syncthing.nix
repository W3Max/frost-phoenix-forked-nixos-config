{ pkgs, age, ... }: {
  # https://github.com/nix-community/home-manager/blob/master/modules/services/syncthing.nix
  services.syncthing = {
    enable = true;

    settings = {
      devices = {

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

      folders = {
        "w3max-obsidian" = {
          id = "6c44y-t3joa";
          path = "/home/w3max/Documents/Obsidian/w3max-obsidian";
          devices = [ "Maxime-s-S22-Ultra" "raspberrypi" ];
        };
      };

      options.globalAnnounceEnabled = false; # Only sync on LAN
    };

  };
}
