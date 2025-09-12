{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Age key automatically generated during installation via generateKey = true

  powerManagement.cpuFreqGovernor = "performance";
}
