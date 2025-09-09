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

      # SSH host key secret - for SSH server
      ssh-host-key = {
        sopsFile = ../../sops/secrets/ssh-host-keys.yaml;
        key = "ssh_host_key_ed25519";
        mode = "0600";
        owner = "root";
        group = "root";
        path = "/etc/ssh/ssh_host_ed25519_key";
      };
    };
  };
}
