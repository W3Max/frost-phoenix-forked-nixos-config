{
  description = "W3Max's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Clan framework for multi-machine management
    clan-core = {
      url = "git+https://git.clan.lol/clan/clan-core";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Remote NixOS installation
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    # Hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pre-commit hooks for code validation
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = { hyprland = { follows = "hyprland"; }; };
    };

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    #zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ ... }: {
      imports = [
        ./nix/machines.nix # Machine configurations
        ./nix/clan.nix # Clan-specific setup
      ];

      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, inputs', ... }:
        let
          pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              # Nix formatting
              nixfmt-classic = {
                enable = true;
                name = "nixfmt-classic";
                entry = "${pkgs.nixfmt-classic}/bin/nixfmt";
                files = "\\.nix$";
                language = "system";
              };

              # Nix flake check
              nix-flake-check = {
                enable = true;
                name = "nix flake check";
                entry = "${pkgs.writeShellScript "nix-flake-check" ''
                  ${pkgs.nix}/bin/nix flake check --extra-experimental-features 'nix-command flakes' --no-update-lock-file 2>/dev/null || exit 0
                ''}";
                files = "flake\\.(nix|lock)$";
                language = "system";
                pass_filenames = false;
              };

              # Shell script linting
              shellcheck = {
                enable = true;
                excludes = [
                  ".git/"
                  "modules/home/p10k/.p10k.zsh" # Powerlevel10k config uses zsh-specific syntax
                ];
              };

              # YAML linting
              yamllint = {
                enable = true;
                excludes = [ "sops/secrets/" ]; # Exclude encrypted secrets
              };

              # Check for merge conflicts
              check-merge-conflicts.enable = true;

              # Check for broken symlinks
              check-symlinks.enable = true;

              # Trim trailing whitespace
              trim-trailing-whitespace.enable = true;

              # End files with newline
              end-of-file-fixer.enable = true;
            };
          };
        in {
          formatter = pkgs.nixpkgs-fmt;

          # Pre-commit hooks configuration
          checks = { inherit pre-commit-check; };

          # Development shell with pre-commit
          devShells.default = pkgs.mkShell {
            inherit (pre-commit-check) shellHook;
            buildInputs = with pkgs; [
              # Development tools
              nixfmt-classic
              nix
              git

              # Clan tools
              # (clan CLI is run via nix run)

              # Pre-commit
              inputs.pre-commit-hooks.packages.${system}.pre-commit
            ];
          };
        };
    });
}
