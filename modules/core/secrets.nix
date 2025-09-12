# Clan secrets integration
{ config, inputs, host, ... }: {
  # Clan handles sops integration automatically through clanCore module

  # Configure sops with machine-specific age key
  sops = {
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      # Automatically generate age key during installation
      generateKey = true;
      # Also support SSH host keys as fallback
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

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
