{ ... }: {
  imports =
    [ ./hardware-configuration.nix ./configuration.nix ./disk-config.nix ];

  # Deploy machine-specific age key for secrets
  environment.etc."machine-age-key" = {
    text = builtins.readFile ./secrets/w3max-workstation.key;
    mode = "0400";
  };
}
