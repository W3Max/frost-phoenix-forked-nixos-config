# modules/core/clan-settings.nix
# Core Clan settings that need to be present on all machines
{ host, ... }: {
  clan.core.settings = {
    # Directory where clan configuration lives
    directory = "/home/w3max/nixos-config";
    # Machine-specific settings
    machine = { name = host; };
  };
}
