# Common home-manager configuration shared across all machines
{ ... }: {
  imports = [
    # Essential home modules that everyone needs
    ./home/bat.nix
    ./home/btop.nix
    ./home/fastfetch.nix
    ./home/fzf.nix
    ./home/micro.nix
    ./home/zsh
    ./home/p10k/p10k.nix
  ];
}
