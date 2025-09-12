{ ... }: {
  imports =
    [ ./hardware-configuration.nix ./configuration.nix ./disk-config.nix ];

  # Age key automatically generated during installation via generateKey = true
}
