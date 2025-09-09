# modules/core/clan-settings.nix
# Core Clan settings that need to be present on all machines
{ ... }:
{
  clan.core.settings = {
    # Directory where clan configuration lives
    directory = "/home/w3max/nixos-config";
  };
}