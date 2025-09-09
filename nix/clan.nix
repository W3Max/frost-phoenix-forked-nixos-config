# nix/clan.nix
# Clan configuration for multi-machine management
{ self, inputs, ... }:
{
  # Clan configuration goes in flake outputs
  flake = {
    # This will be used by Clan's tooling
    clanInternals = {
      machines = {
        desktop = {
          description = "Main desktop system";
          tags = [ "desktop" ];
          targetHost = "root@desktop.local";
        };
        
        laptop = {
          description = "Mobile laptop system";
          tags = [ "laptop" "mobile" ];
          targetHost = "root@laptop.local";
        };
        
        vm = {
          description = "Virtual machine for testing";
          tags = [ "vm" "test" ];
          targetHost = "root@vm.local";
        };
        
        w3max-workstation = {
          description = "AMD Ryzen 7800X3D + RX 7900 XTX Gaming/Dev Station";
          tags = [ "desktop" "gaming" "development" "storage-server" ];
          targetHost = "root@w3max-workstation.local";
        };
      };
      
      # Clan meta information
      meta = {
        name = "W3Max-Clan";
        description = "Personal computing infrastructure";
      };
    };
  };
}