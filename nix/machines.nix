# nix/machines.nix
{ self, inputs, lib, ... }:
let
  username = "w3max";
in
{
  flake.nixosConfigurations = {
    # Desktop configuration
    desktop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        host = "desktop";
        inherit self inputs username;
      };
      modules = [
        inputs.clan-core.nixosModules.clanCore
        inputs.disko.nixosModules.disko
        ../modules/common.nix
        ../modules/desktop.nix
        ../modules/development.nix
        ../modules/gaming.nix
        ../machines/desktop
      ];
    };
    
    # Laptop configuration
    laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        host = "laptop";
        inherit self inputs username;
      };
      modules = [
        inputs.clan-core.nixosModules.clanCore
        inputs.disko.nixosModules.disko
        ../modules/common.nix
        ../modules/desktop.nix
        ../modules/development.nix
        ../machines/laptop
      ];
    };
    
    # VM configuration
    vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        host = "vm";
        inherit self inputs username;
      };
      modules = [
        inputs.clan-core.nixosModules.clanCore
        inputs.disko.nixosModules.disko
        ../modules/common.nix
        ../modules/desktop.nix
        ../machines/vm
      ];
    };
    
    # W3Max Workstation - AMD Ryzen 7800X3D + RX 7900 XTX
    w3max-workstation = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        inherit inputs self username;
        host = "w3max-workstation";
      };
      modules = [
        # Core modules
        inputs.clan-core.nixosModules.clanCore
        inputs.disko.nixosModules.disko
        
        # Hardware optimizations
        inputs.nixos-hardware.nixosModules.common-cpu-amd
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
        inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.nixos-hardware.nixosModules.common-pc-ssd
        
        # Module groups
        ../modules/common.nix
        ../modules/desktop.nix
        ../modules/development.nix
        ../modules/gaming.nix
        
        # Machine-specific configuration
        ../machines/w3max-workstation
      ];
    };
  };
}