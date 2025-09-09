# Development home-manager configuration
{ ... }: {
  imports = [
    # Home development modules
    ./home/git.nix
    ./home/lazygit.nix
    ./home/vscodium
    ./home/ssh.nix
    ./home/flow.nix
    ./home/nix-search/nix-search.nix
    ./home/superfile/superfile.nix
    ./home/packages
    ./home/scripts/scripts.nix
  ];
}
