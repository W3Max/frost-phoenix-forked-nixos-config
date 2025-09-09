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

      # Nixos
      cdnix = "cd ~/nixos-config && codium ~/nixos-config";
      ns = "nom-shell --run zsh";
      nd = "nom develop --command zsh";
      nb = "nom build";
      nc = "nh clean all --keep 5";
      nft = "nh os test";
      nfs = "nh os switch";
      nfu = "nh os switch --update";
      npc = "nix develop -c pre-commit run --all-files";
      # nix-search = "nh search";

      # Clan management
      clanl = "nix run github:clan-lol/clan-core -- machines list";
      clans = "nix run github:clan-lol/clan-core -- machines status";
      cland = "nix run github:clan-lol/clan-core -- machines deploy";
      clandr = "nix run github:clan-lol/clan-core -- machines deploy --dry-run";
      clandu =
        "nix run github:clan-lol/clan-core -- machines deploy --update-all";
      clansh = "nix run github:clan-lol/clan-core -- machines show";
      clansl = "nix run github:clan-lol/clan-core -- secrets list";
      clanss = "nix run github:clan-lol/clan-core -- secrets set";
      clansg = "nix run github:clan-lol/clan-core -- secrets get";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };
}
