{ lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

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
