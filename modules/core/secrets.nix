# Clan secrets integration
{ config, inputs, host, ... }: {
  # Clan handles sops integration automatically through clanCore module

  # Configure sops with machine-specific age key
  sops = {
    defaultSopsFile = ../../sops/secrets/user-password.yaml;
    # Key should be manually placed at this location on each machine
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      # User password secret
      user-password = {
        neededForUsers = true;
        key = "user_password";
      };

      # SSH host key secret
      ssh-host-key = {
        sopsFile = ../../sops/secrets/ssh-host-keys.yaml;
        key = "ssh_host_key_ed25519";
        mode = "0600";
        owner = "root";
        group = "root";
      };

      # API tokens
      github-token = {
        sopsFile = ../../sops/secrets/api-tokens.yaml;
        key = "api_tokens.github";
      };
    };
  };
}
