# Common configuration shared across all machines
{ ... }: {
  imports = [
    # Essential system modules
    ./core/bootloader.nix
    ./core/clan-settings.nix
    ./core/hardware.nix
    ./core/network.nix
    ./core/secrets.nix
    ./core/security.nix
    ./core/system.nix
    ./core/user.nix
    ./core/program.nix
  ];
}
