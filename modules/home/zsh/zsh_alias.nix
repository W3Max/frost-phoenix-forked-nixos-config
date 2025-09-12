{ ... }: {
  programs.zsh = {
    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      tt = "gtrash put";
      cat = "bat";
      nano = "micro";
      code = "codium";
      diff = "delta --diff-so-fancy --side-by-side";
      less = "bat";
      f = "superfile";
      py = "python";
      ipy = "ipython";
      icat = "kitten icat";
      dsize = "du -hs";
      pdf = "tdf";
      open = "xdg-open";
      space = "ncdu";
      man = "BAT_THEME='default' batman";

      l = "eza --icons  -a --group-directories-first -1"; # EZA_ICON_SPACING=2
      ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
      tree = "eza --icons --tree --group-directories-first";

      # Nixos - Local Management (nh for better UX)
      cdnix = "cd ~/nixos-config && codium ~/nixos-config";
      ns = "nom-shell --run zsh";
      nd = "nom develop --command zsh";
      nb = "nom build";
      nc = "nh clean all --keep 5";
      nfs = "nh os switch"; # Local switch with build visualization
      nfu = "nh os switch --update"; # Update flake & switch locally
      nft = "nh os test"; # Test configuration
      npc = "nix develop -c pre-commit run --all-files";
      nfmt = "nix fmt";
      ncheck = "nix flake check";

      # Clan - Remote Deployment & Installation
      clan = "nix run github:clan-lol/clan-core --";
      cml = "nix run github:clan-lol/clan-core -- machines list";
      cmi =
        "nix run github:clan-lol/clan-core -- machines install"; # Initial installation
      cmr =
        "nix run github:clan-lol/clan-core -- machines update --target-host"; # Remote update
      cmua =
        "nix run github:clan-lol/clan-core -- machines update"; # Update all machines
      cmhw =
        "nix run github:clan-lol/clan-core -- machines update-hardware-config";
      cmc = "nix run github:clan-lol/clan-core -- machines create";
      cms = "nix run github:clan-lol/clan-core -- show";
      cmst = "nix run github:clan-lol/clan-core -- state query";

      # Clan - Secrets
      csl = "nix run github:clan-lol/clan-core -- secrets list";
      css = "nix run github:clan-lol/clan-core -- secrets set";
      cse = "nix run github:clan-lol/clan-core -- secrets set --edit";
      csg = "nix run github:clan-lol/clan-core -- secrets get";
      csr = "nix run github:clan-lol/clan-core -- secrets remove";
      csu = "nix run github:clan-lol/clan-core -- secrets users";

      # Clan - Advanced
      cvms = "nix run github:clan-lol/clan-core -- vms start";
      cvml = "nix run github:clan-lol/clan-core -- vms list";
      cnet = "nix run github:clan-lol/clan-core -- network";
      cbak = "nix run github:clan-lol/clan-core -- backups";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };
}
