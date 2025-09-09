{ ... }: {
  imports =
    [ ./hardware-configuration.nix ./configuration.nix ./disk-config.nix ];

  # Machine-specific age key should be manually placed at /var/lib/sops-nix/key.txt
  # Generate with: age-keygen -o /var/lib/sops-nix/key.txt
  # Set permissions: sudo chmod 600 /var/lib/sops-nix/key.txt
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}
