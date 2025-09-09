# Gaming home-manager configuration
{ ... }:
{
  imports = [
    # Home gaming modules
    ./home/gaming.nix
    ./home/discord.nix
  ];
}