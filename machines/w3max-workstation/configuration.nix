{ config, pkgs, lib, inputs, ... }:

{
  # Boot configuration optimized for your hardware
  boot = {
    loader = {
      # These are already set in modules/core/bootloader.nix
      # systemd-boot.enable = true;
      # efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    # Latest kernel for best AMD support
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    # Kernel parameters optimized for AMD Ryzen 7800X3D & RX 7900 XTX
    kernelParams = [
      "amd_pstate=active" # Better CPU power management
      "amd_pstate.shared_mem=1" # Enable shared memory for pstate
      "processor.max_cstate=1" # Reduce latency for gaming
      "rcu_nocbs=0-15" # Offload RCU callbacks
      "mitigations=off" # Disable mitigations for max performance (gaming)
      "threadirqs" # Thread IRQs for better latency
      "tsc=reliable" # Trust TSC for timekeeping
      "clocksource=tsc" # Use TSC as clocksource
    ];

    # Support for your hardware
    initrd.kernelModules = [
      "amdgpu" # AMD GPU driver
      "nvme" # NVMe support
      "btrfs" # Btrfs filesystem
    ];

    # Enable AMD GPU firmware
    kernelModules = [ "kvm-amd" "amdgpu" ];

    # Btrfs optimizations
    supportedFilesystems = [ "btrfs" "ext4" "vfat" ];
  };

  # Hardware configuration
  # Hardware configuration
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;

    # AMD GPU configuration
    graphics = { # Changed from opengl to graphics
      enable = true;
      enable32Bit = true; # For 32-bit games
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # Fixed ROCm package name
        amdvlk
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ amdvlk ];
    };
  };

  # Networking configuration
  networking = {
    hostName = "w3max-workstation";

    # Enable both network interfaces
    interfaces = {
      # Configure based on your actual interface names
      # Run 'ip link' to find them
      enp5s0.useDHCP = true; # Onboard 2.5Gb
      enp6s0.useDHCP = true; # PCI 2.5Gb
    };

    # Enable firewall with Clan-friendly settings
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ]; # SSH for remote management
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Essential tools
    vim
    git
    htop
    btop
    neofetch

    # Filesystem tools
    btrfs-progs
    compsize # Check btrfs compression

    # Network tools
    ethtool
    iperf3

    # AMD tools
    lm_sensors
    radeontop # AMD GPU monitoring

    # Development
    gcc
    gnumake
  ];

  # Services
  services = {
    # SSH for remote management
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    # Btrfs maintenance
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" "/home" "/data" ];
    };

    # AMD GPU power management
    power-profiles-daemon.enable = false; # Conflicts with TLP
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_BOOST_ON_AC = 1;
        RADEON_DPM_PERF_LEVEL_ON_AC = "high";
        RADEON_DPM_STATE_ON_AC = "performance";
      };
    };

    # Enable fstrim for SSDs
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };

  # Additional user groups for w3max-workstation
  users.users.w3max = {
    extraGroups = lib.mkForce [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsP7oWQgJLPc2BZXhC31RhVXzYd0/FVlqPpYDkAjH3g m@w3max.me"
    ];
  };

  # System state version
  system.stateVersion = "24.05";

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      # Use all cores for building
      max-jobs = 16;
      cores = 16;
    };
  };

  # Enable zram for better memory management
  zramSwap = {
    enable = true;
    memoryPercent = 25; # Use 25% of RAM as zram (8GB)
  };
}
