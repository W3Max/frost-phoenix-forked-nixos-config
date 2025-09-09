{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Deploy machine-specific age key for secrets
  environment.etc."machine-age-key" = {
    text = builtins.readFile ./secrets/vm.key;
    mode = "0400";
  };

  # kvm/qemu doesn't use UEFI firmware mode by default.
  # so we force-override the setting here
  # and configure GRUB instead.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = false;

  # SSH configuration for VM - secured for testing environment
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "w3max" ];
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
    };
  };
}
