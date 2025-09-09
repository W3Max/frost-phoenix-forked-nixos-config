# Clan Management Guide

This document covers managing your NixOS infrastructure using Clan framework.

## Overview

Clan provides unified management for:
- **Multi-machine deployments**
- **Secret management**
- **Service orchestration**
- **Infrastructure as code**

## Machine Management

### Available Machines

| Machine | Description | Tags | Modules |
|---------|-------------|------|---------|
| `desktop` | Full-featured desktop | desktop | common + desktop + development + gaming |
| `laptop` | Mobile development | laptop, mobile | common + desktop + development |
| `vm` | Testing environment | vm, test | common + desktop |
| `w3max-workstation` | High-end gaming/dev | desktop, gaming, storage | common + desktop + development + gaming |

### Basic Operations

```bash
# List all configured machines
nix run github:clan-lol/clan-core -- machines list

# Show machine details
nix run github:clan-lol/clan-core -- machines show w3max-workstation

# Check machine status
nix run github:clan-lol/clan-core -- machines status
```

### Deployment

```bash
# Deploy configuration to specific machine
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

# Deploy to all machines
nix run github:clan-lol/clan-core -- machines deploy

# Deploy with flake updates
nix run github:clan-lol/clan-core -- machines deploy --update-all

# Dry run (check what would change)
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --dry-run
```

## Secret Management

### User Management

```bash
# Add new user with age key
nix run github:clan-lol/clan-core -- secrets users add alice --age-key age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p

# List users
nix run github:clan-lol/clan-core -- secrets users list

# Get user's public keys
nix run github:clan-lol/clan-core -- secrets users get alice
```

### Machine Secret Access

```bash
# List machines with secret access
nix run github:clan-lol/clan-core -- secrets machines list

# Add machine to secret system
nix run github:clan-lol/clan-core -- secrets machines add new-machine <age-public-key>

# Allow machine access to specific secret
nix run github:clan-lol/clan-core -- secrets machines add-secret desktop my-secret
```

### Secret Operations

```bash
# List all secrets
nix run github:clan-lol/clan-core -- secrets list

# Create new secret (will prompt for content)
nix run github:clan-lol/clan-core -- secrets set database-password

# View secret (requires access)
nix run github:clan-lol/clan-core -- secrets get database-password

# Rename secret
nix run github:clan-lol/clan-core -- secrets rename old-name new-name

# Remove secret
nix run github:clan-lol/clan-core -- secrets remove old-secret
```

## Service Management

### Available Services

Future service integrations planned:
- **Backup Services**: Automated backups with Restic
- **Monitoring**: Prometheus + Grafana stack
- **VPN**: WireGuard mesh networking
- **Storage**: Distributed storage coordination

### Service Operations

```bash
# Future: List available services
nix run github:clan-lol/clan-core -- services list

# Future: Deploy service across machines
nix run github:clan-lol/clan-core -- services deploy backup-service

# Future: Check service health
nix run github:clan-lol/clan-core -- services status
```

## Network Management

### Machine Discovery

```bash
# Check network connectivity
nix run github:clan-lol/clan-core -- network status

# Show network topology
nix run github:clan-lol/clan-core -- network show
```

### Mesh Networking

```bash
# Future: Set up machine mesh
nix run github:clan-lol/clan-core -- network mesh-setup

# Future: Add peer connection
nix run github:clan-lol/clan-core -- machines add-peer desktop laptop
```

## Deployment Strategies

### Initial Setup

For new machines, use the deployment script approach:

```bash
# Remote installation with nixos-anywhere
./scripts/deploy.sh 192.168.1.100

# Then transition to clan management
nix run github:clan-lol/clan-core -- machines deploy new-machine
```

### Ongoing Management

For existing clan-managed machines:

```bash
# Regular updates
nix run github:clan-lol/clan-core -- machines deploy --update-all

# Emergency deployment
nix run github:clan-lol/clan-core -- machines deploy critical-machine

# Coordination across machines
nix run github:clan-lol/clan-core -- machines deploy desktop laptop vm
```

## Configuration Management

### Clan Inventory

The clan configuration is defined in `nix/clan.nix`:

```nix
clanInternals = {
  inventoryClass = {
    inventory = {
      machines = {
        desktop = {
          description = "Main desktop system";
          tags = [ "desktop" ];
          targetHost = "root@desktop.local";
        };
        # ... other machines
      };

      meta = {
        name = "W3Max-Clan";
        description = "Personal computing infrastructure";
      };
    };
  };
};
```

### Adding New Machines

1. **Add to clan inventory** in `nix/clan.nix`
2. **Create machine directory** in `machines/new-machine/`
3. **Generate age key** and add to secret system
4. **Deploy configuration**

```bash
# Generate machine key
nix-shell -p age --run "age-keygen -o new-machine.key"

# Add to clan
nix run github:clan-lol/clan-core -- secrets machines add new-machine <public-key>

# Deploy
nix run github:clan-lol/clan-core -- machines deploy new-machine
```

## Monitoring & Health Checks

### System Health

```bash
# Check all machines
nix run github:clan-lol/clan-core -- machines health-check

# Check specific machine
nix run github:clan-lol/clan-core -- machines status desktop

# Network diagnostics
nix run github:clan-lol/clan-core -- network diagnostics
```

### Logs & Debugging

```bash
# View deployment logs
nix run github:clan-lol/clan-core -- machines logs desktop

# Debug connection issues
nix run github:clan-lol/clan-core -- machines debug desktop

# Test secret access
nix run github:clan-lol/clan-core -- secrets test desktop
```

## Best Practices

### Security
- **Rotate secrets regularly** using clan commands
- **Backup age keys** before major changes
- **Use least privilege** - only grant necessary secret access
- **Test deployments** on non-critical machines first

### Operations
- **Update in stages**: Test on VM, then laptop, then desktop
- **Monitor deployments**: Check health after each deployment
- **Keep inventory current**: Update descriptions and tags
- **Document changes**: Update configuration comments

### Recovery
- **Keep offline backups** of age keys
- **Document emergency procedures** for each machine type
- **Test recovery procedures** regularly
- **Maintain deployment scripts** as backup to clan commands

## Integration with Other Tools

### With nixos-anywhere
- Use for initial installations
- Transition to clan for ongoing management

### With Home Manager
- Clan manages system-level secrets
- Home Manager handles user-specific configurations
- Both coordinate through the flake structure

### With Development Workflow
- Use clan commands in development shell
- Integrate with pre-commit hooks for validation
- Coordinate with the existing build and test processes
