# Clan secrets integration
{ config, inputs, host, ... }: {
  # Clan handles sops integration automatically through clanCore module

  # Configure sops with machine-specific age key
  sops = {
    defaultSopsFile = ../../sops/secrets/user-password.yaml;
    age.keyFile = "/etc/machine-age-key";

    secrets = {
      # User password secret
      user-password = { neededForUsers = true; };

      # SSH host key secret
      ssh-host-key = {
        sopsFile = ../../sops/secrets/ssh-host-keys.yaml;
        key = "ssh_host_key_ed25519";
        mode = "0600";
        owner = "root";
        group = "root";
      };

      # WireGuard private key
      wireguard-key = {
        sopsFile = ../../sops/secrets/wireguard-keys.yaml;
        key = "wireguard_private_key";
        mode = "0600";
        owner = "systemd-network";
        group = "systemd-network";
      };

      # API tokens
      github-token = {
        sopsFile = ../../sops/secrets/api-tokens.yaml;
        key = "api_tokens.github";
      };

      backup-token = {
        sopsFile = ../../sops/secrets/api-tokens.yaml;
        key = "api_tokens.backup_service";
      };
    };
  };
}
