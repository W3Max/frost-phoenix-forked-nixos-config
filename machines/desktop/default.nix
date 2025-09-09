{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Deploy machine-specific age key for secrets
  environment.etc."machine-age-key" = {
    text = builtins.readFile ./secrets/desktop.key;
    mode = "0400";
  };

  powerManagement.cpuFreqGovernor = "performance";
}
