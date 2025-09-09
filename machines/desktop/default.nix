{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
