{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Machine-specific age key should be manually placed at /var/lib/sops-nix/key.txt
  # Generate with: age-keygen -o /var/lib/sops-nix/key.txt
  # Set permissions: sudo chmod 600 /var/lib/sops-nix/key.txt
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

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
