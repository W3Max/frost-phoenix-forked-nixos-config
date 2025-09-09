{ ... }: {
  disko.devices = {
    disk = {
      # Kingston KC3000 2TB - Primary System Drive
      nvme0 = {
        type = "disk";
        device = "/dev/nvme0n1"; # Adjust if needed
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" "umask=0077" ];
              };
            };
            swap = {
              priority = 2;
              size = "32G"; # Match your RAM for hibernation support
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
            root = {
              priority = 3;
              size = "200G"; # System and programs
              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L" "nixos-root" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions =
                      [ "compress=zstd:1" "noatime" "ssd" "space_cache=v2" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions =
                      [ "compress=zstd:3" "noatime" "ssd" "space_cache=v2" ];
                  };
                  "/snapshots" = {
                    mountpoint = "/snapshots";
                    mountOptions =
                      [ "compress=zstd:1" "noatime" "ssd" "space_cache=v2" ];
                  };
                };
              };
            };
            games = {
              priority = 4;
              size = "100%"; # Remaining space (~1.7TB) for games
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/games";
                mountOptions = [ "defaults" "noatime" ];
              };
            };
          };
        };
      };

      # WD Blue SN5000 1TB - Development & Home
      nvme1 = {
        type = "disk";
        device = "/dev/nvme1n1"; # Adjust if needed
        content = {
          type = "gpt";
          partitions = {
            home = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L" "home" ];
                subvolumes = {
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions =
                      [ "compress=zstd:1" "noatime" "ssd" "space_cache=v2" ];
                  };
                  "/docker" = {
                    mountpoint = "/var/lib/docker";
                    mountOptions =
                      [ "compress=no" "noatime" "ssd" "space_cache=v2" ];
                  };
                  "/vms" = {
                    mountpoint = "/var/lib/libvirt";
                    mountOptions = [
                      "compress=no"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                      "nodatacow"
                    ];
                  };
                };
              };
            };
          };
        };
      };

      # Seagate IronWolf 8TB - Bulk Storage
      sda = {
        type = "disk";
        device = "/dev/sda"; # Adjust based on your system
        content = {
          type = "gpt";
          partitions = {
            storage = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L" "storage" ];
                subvolumes = {
                  "/data" = {
                    mountpoint = "/data";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "space_cache=v2"
                      "autodefrag"
                    ];
                  };
                  "/backups" = {
                    mountpoint = "/backups";
                    mountOptions =
                      [ "compress=zstd:9" "noatime" "space_cache=v2" ];
                  };
                  "/media" = {
                    mountpoint = "/media/storage";
                    mountOptions =
                      [ "compress=zstd:1" "noatime" "space_cache=v2" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
