# Clan Management Workflows

This guide covers common workflows for managing your NixOS infrastructure with Clan after initial deployment.

## 🚀 Common Workflows

### Daily Operations

#### Configuration Updates
```bash
# Update a single machine
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

# Update all machines
nix run github:clan-lol/clan-core -- machines deploy

# Update with latest flake inputs
nix run github:clan-lol/clan-core -- machines deploy --update-all
```

#### System Monitoring
```bash
# Check status of all machines
nix run github:clan-lol/clan-core -- machines status

# Health check cluster
nix run github:clan-lol/clan-core -- machines health-check

# Show detailed machine info
nix run github:clan-lol/clan-core -- machines show w3max-workstation
```

### Multi-Machine Coordination

#### Setting Up Machine Mesh
```bash
# Add machines to mesh network
nix run github:clan-lol/clan-core -- machines add-peer desktop laptop
nix run github:clan-lol/clan-core -- machines add-peer w3max-workstation vm

# Verify mesh connectivity
nix run github:clan-lol/clan-core -- machines ping desktop
```

#### Service Management
```bash
# List available services
nix run github:clan-lol/clan-core -- services list

# Enable services across machines
nix run github:clan-lol/clan-core -- services enable zerotier
nix run github:clan-lol/clan-core -- services enable backup-sync

# Check service status
nix run github:clan-lol/clan-core -- services status
```

### Development Workflows

#### Testing Configuration Changes
```bash
# Test changes without applying
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --dry-run

# Deploy to test VM first
nix run github:clan-lol/clan-core -- machines deploy vm

# Then deploy to production systems
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation
```

#### Rollback Support
```bash
# List previous generations
nix run github:clan-lol/clan-core -- machines history w3max-workstation

# Rollback to previous generation
nix run github:clan-lol/clan-core -- machines rollback w3max-workstation

# Rollback to specific generation
nix run github:clan-lol/clan-core -- machines rollback w3max-workstation --generation 42
```

## 🔧 Advanced Operations

### Backup and Recovery

#### Automated Backups
```bash
# Enable backup service
nix run github:clan-lol/clan-core -- services enable borgbackup

# Configure backup targets
nix run github:clan-lol/clan-core -- secrets set backup-encryption-key

# Run manual backup
nix run github:clan-lol/clan-core -- services run backup-sync
```

#### Disaster Recovery
```bash
# Bootstrap replacement machine
./scripts/deploy.sh <new-machine-ip>

# Restore from backup
nix run github:clan-lol/clan-core -- services run restore-from-backup

# Rejoin cluster mesh
nix run github:clan-lol/clan-core -- machines add-peer <machine-name>
```

### Secret Management

#### Managing Secrets
```bash
# List all secrets
nix run github:clan-lol/clan-core -- secrets list

# Add new secret (will prompt for content)
nix run github:clan-lol/clan-core -- secrets set api-key

# View secret (requires admin access)
nix run github:clan-lol/clan-core -- secrets get database-password

# Rename secret
nix run github:clan-lol/clan-core -- secrets rename old-name new-name

# Remove secret
nix run github:clan-lol/clan-core -- secrets remove old-secret
```

#### User & Machine Access
```bash
# Add user with age key
nix run github:clan-lol/clan-core -- secrets users add alice --age-key <age-public-key>

# List users with secret access
nix run github:clan-lol/clan-core -- secrets users list

# Add machine to secret system
nix run github:clan-lol/clan-core -- secrets machines add new-machine <age-public-key>

# Grant machine access to specific secret
nix run github:clan-lol/clan-core -- secrets machines add-secret desktop my-secret
```

#### Secret Integration
Current secrets available in configurations:
- `user-password` - User account passwords
- `ssh-host-key` - SSH host keys
- `wireguard-key` - VPN private keys
- `github-token` - GitHub API access
- `backup-token` - Backup service credentials

Access in NixOS config: `config.sops.secrets.<name>.path`

### Performance Monitoring

#### System Metrics
```bash
# Enable monitoring stack
nix run github:clan-lol/clan-core -- services enable monitoring

# View machine metrics
nix run github:clan-lol/clan-core -- machines metrics w3max-workstation

# Generate performance report
nix run github:clan-lol/clan-core -- machines report
```

## 🏗️ Infrastructure Patterns

### Development Environment
```bash
# Development machine setup
nix run github:clan-lol/clan-core -- machines deploy laptop --profile development

# Enable development services
nix run github:clan-lol/clan-core -- services enable docker
nix run github:clan-lol/clan-core -- services enable postgres-dev
```

### Gaming Rig Management
```bash
# Gaming-optimized deployment
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --profile gaming

# Monitor gaming performance
nix run github:clan-lol/clan-core -- machines metrics w3max-workstation --filter gaming
```

### Home Lab Setup
```bash
# Deploy storage server
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --profile storage

# Enable NAS services
nix run github:clan-lol/clan-core -- services enable samba
nix run github:clan-lol/clan-core -- services enable jellyfin
```

## 🐛 Troubleshooting

### Common Issues

#### Connection Problems
```bash
# Debug SSH connectivity
nix run github:clan-lol/clan-core -- machines debug-ssh w3max-workstation

# Test network connectivity
nix run github:clan-lol/clan-core -- machines ping w3max-workstation

# Check machine availability
nix run github:clan-lol/clan-core -- machines status --verbose
```

#### Deployment Failures
```bash
# Check deployment logs
nix run github:clan-lol/clan-core -- machines logs w3max-workstation

# Retry with debug output
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --debug

# Force rebuild cache
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --rebuild
```

### Recovery Procedures

#### Network Issues
```bash
# Reset mesh configuration
nix run github:clan-lol/clan-core -- machines reset-mesh w3max-workstation

# Rejoin mesh network
nix run github:clan-lol/clan-core -- machines join-mesh w3max-workstation
```

#### Service Recovery
```bash
# Restart failed services
nix run github:clan-lol/clan-core -- services restart backup-sync

# Reset service configuration
nix run github:clan-lol/clan-core -- services reset zerotier
```

## 📚 Best Practices

1. **Always test on VM first** before deploying to production machines
2. **Use --dry-run** to preview changes before applying
3. **Monitor system health** regularly with status checks
4. **Keep backups** of important secrets and configurations
5. **Document custom workflows** specific to your environment
6. **Use tags** to organize machines by function/environment
7. **Implement gradual rollouts** for major configuration changes

## 🔗 Integration with nixos-anywhere

Remember: Use `scripts/deploy.sh` (nixos-anywhere) for initial installation, then switch to Clan commands for ongoing management. This dual approach gives you the best of both worlds - reliable bootstrapping and powerful infrastructure management.
