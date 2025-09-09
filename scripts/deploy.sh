#!/usr/bin/env bash
set -euo pipefail

# Configuration
TARGET_HOST="${1:-}"
TARGET_USER="root"
SSH_PORT="${SSH_PORT:-22}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check arguments
if [ -z "$TARGET_HOST" ]; then
    log_error "Usage: $0 <target-host-ip>"
    echo "Example: $0 192.168.1.100"
    exit 1
fi

log_info "Starting Clan/NixOS deployment to $TARGET_HOST"

# Step 1: Verify connectivity
log_info "Testing SSH connectivity..."
if ! ssh -p "$SSH_PORT" -o ConnectTimeout=5 "$TARGET_USER@$TARGET_HOST" "echo 'SSH connection successful'"; then
    log_error "Cannot connect to $TARGET_HOST. Ensure:"
    echo "  1. Target is booted into NixOS installer ISO"
    echo "  2. SSH is enabled (set root password in installer)"
    echo "  3. Network is configured"
    exit 1
fi

# Step 2: Detect disk devices on target
log_info "Detecting disk devices on target system..."
ssh -p "$SSH_PORT" "$TARGET_USER@$TARGET_HOST" "lsblk -d -o NAME,SIZE,MODEL" || true

echo ""
log_warn "Please verify the disk devices in disk-config.nix match your system:"
echo "  - nvme0n1 should be your Kingston KC3000 2TB"
echo "  - nvme1n1 should be your WD Blue SN5000 1TB"
echo "  - sda should be your Seagate IronWolf 8TB"
echo ""
read -p "Are the disk assignments correct? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_error "Please update machines/w3max-workstation/disk-config.nix with correct device paths"
    exit 1
fi

# Step 3: Generate hardware configuration
log_info "Generating hardware configuration..."
ssh -p "$SSH_PORT" "$TARGET_USER@$TARGET_HOST" \
    "nixos-generate-config --root /mnt --show-hardware-config" > machines/w3max-workstation/hardware-configuration.nix

log_info "Hardware configuration saved to machines/w3max-workstation/hardware-configuration.nix"

# Step 4: Prepare flake
log_info "Preparing deployment flake..."
if [ ! -f "flake.nix" ]; then
    log_error "flake.nix not found in current directory"
    exit 1
fi

# Update flake inputs
log_info "Updating flake inputs..."
nix flake update

# Step 5: Run nixos-anywhere
log_info "Starting NixOS installation with nixos-anywhere..."
log_warn "This will ERASE ALL DATA on the target disks!"
read -p "Continue with installation? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Installation cancelled"
    exit 0
fi

# Build the system configuration first
log_info "Building system configuration..."
nix build .#nixosConfigurations.w3max-workstation.config.system.build.toplevel

# Deploy with nixos-anywhere
log_info "Deploying with nixos-anywhere..."
nix run github:nix-community/nixos-anywhere -- \
    --flake .#w3max-workstation \
    --target-host "$TARGET_USER@$TARGET_HOST" \
    --build-on-remote \
    --debug

log_info "Installation complete! The system will reboot."
log_info "After reboot, you can connect with: ssh w3max@$TARGET_HOST"

# Step 6: Post-installation setup
cat << EOF

${GREEN}=== Post-Installation Complete! ===${NC}

🎉 Your NixOS system has been successfully deployed with nixos-anywhere!

${GREEN}=== Next Steps: Transition to Clan Management ===${NC}

Now that your system is installed, use Clan for ongoing management:

${YELLOW}1. Verify Clan Integration:${NC}
   nix run github:clan-lol/clan-core -- machines list
   nix run github:clan-lol/clan-core -- machines show w3max-workstation

${YELLOW}2. Test Clan Deployment (from your management machine):${NC}
   nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --dry-run

${YELLOW}3. Switch to Clan Management:${NC}
   nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

${YELLOW}4. Enable Clan Services (optional):${NC}
   nix run github:clan-lol/clan-core -- services list
   nix run github:clan-lol/clan-core -- services enable zerotier

${GREEN}=== Initial Setup Tasks ===${NC}

Connect to your new system: ssh w3max@$TARGET_HOST

Then consider setting up:
- Clone configuration: git clone https://github.com/W3Max/nixos-config.git ~/nixos-config
- Configure browser settings manually
- Update git credentials in modules/home/git.nix
- Set up development environments in /home
- Configure game libraries in /games
- Set up backups to /backups

${GREEN}=== Performance Notes ===${NC}
✓ AMD-optimized for Ryzen 7800X3D + RX 7900 XTX
✓ CPU governor set to 'performance' on AC power
✓ Security mitigations disabled for gaming performance
✓ Btrfs compression optimized per filesystem type
✓ SSD optimizations enabled across all drives

${YELLOW}=== Tool Usage Summary ===${NC}
• nixos-anywhere (this script): ✅ DONE - Initial installation
• Clan commands: 🔄 USE NEXT - Ongoing management, updates, services

${GREEN}Welcome to your new Clan-ready NixOS system! 🚀${NC}
EOF
