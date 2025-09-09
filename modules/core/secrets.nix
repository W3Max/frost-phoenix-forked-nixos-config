# Clan secrets integration
{ config, inputs, host, ... }: {
  # Clan handles sops integration automatically through clanCore module

  # Configure sops with machine-specific age key
  sops = {
    # Key should be manually placed at this location on each machine
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      # User password secret - needed for user creation
      user-password = {
        sopsFile = ../../sops/secrets/user-password.yaml;
        key = "user_password";
        neededForUsers = true;
      };

      # Additional secrets can be added here as needed
    };
  };
}
