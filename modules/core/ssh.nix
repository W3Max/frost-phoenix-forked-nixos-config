{ config, lib, pkgs, ... }: {
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
      KbdInteractiveAuthentication = false;
      PermitEmptyPasswords = false;
    };

    # Let NixOS auto-generate SSH host keys (Clan-compatible approach)
    # Clan manages SSH connections through its networking layer
  };
}
