# Migration Guide: nixos-anywhere → Clan Management

This guide walks you through transitioning from initial nixos-anywhere deployment to ongoing Clan-based infrastructure management.

## 🎯 Overview

**Migration Path:**
```
Fresh Machine → deploy.sh (nixos-anywhere) → Clan Management → Ongoing Operations
```

This approach gives you:
- ✅ Reliable initial deployment with hardware detection
- ✅ Powerful ongoing management and coordination
- ✅ Best tool for each job

## 🚀 Step-by-Step Migration

### Phase 1: Initial Deployment (nixos-anywhere)

**Use Case:** Fresh machine, new installation, hardware detection needed

```bash
# 1. Boot target into NixOS installer ISO
# 2. Set root password and enable SSH
# 3. Run deployment script
./scripts/deploy.sh 192.168.1.100
```

**What happens:**
- ✅ Hardware configuration generated automatically
- ✅ Disk partitioning via disko configuration
- ✅ Full NixOS system installation
- ✅ Clan modules enabled and ready

### Phase 2: Verification and Transition

**Immediately after initial deployment:**

```bash
# 1. Verify Clan integration is working
nix run github:clan-lol/clan-core -- machines list
# Should show: w3max-workstation

# 2. Check machine details
nix run github:clan-lol/clan-core -- machines show w3max-workstation
# Verify: hostname, tags, target configuration

# 3. Test Clan connectivity
nix run github:clan-lol/clan-core -- machines status
# Should show: machine online and accessible
```

### Phase 3: Switch to Clan Management

**From your management machine:**

```bash
# 1. Test deployment capability (dry-run)
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation --dry-run

# 2. Perform first Clan deployment
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation

# 3. Verify successful deployment
nix run github:clan-lol/clan-core -- machines status w3max-workstation
```

**🎉 Success!** Your machine is now fully managed by Clan.

### Phase 4: Enable Advanced Features

```bash
# Enable mesh networking (if multiple machines)
nix run github:clan-lol/clan-core -- machines add-peer w3max-workstation desktop

# Enable services as needed
nix run github:clan-lol/clan-core -- services list
nix run github:clan-lol/clan-core -- services enable zerotier
nix run github:clan-lol/clan-core -- services enable borgbackup

# Set up monitoring
nix run github:clan-lol/clan-core -- services enable monitoring
```

## 🔄 Ongoing Operations Workflow

### Daily Configuration Updates

**OLD WAY (don't use after migration):**
```bash
# ❌ Don't use nixos-anywhere for updates
./scripts/deploy.sh 192.168.1.100  # Wrong for ongoing management
```

**NEW WAY (use Clan):**
```bash
# ✅ Use Clan for all updates
nix run github:clan-lol/clan-core -- machines deploy w3max-workstation
```

### Adding New Machines

**For each new machine:**
```bash
# 1. Use nixos-anywhere for initial setup
./scripts/deploy.sh <new-machine-ip>

# 2. Immediately transition to Clan
nix run github:clan-lol/clan-core -- machines deploy <new-machine>

# 3. Add to mesh if needed
nix run github:clan-lol/clan-core -- machines add-peer <new-machine> w3max-workstation
```

## 📋 Migration Checklist

### Pre-Migration (nixos-anywhere phase)
- [ ] Target machine booted into NixOS installer
- [ ] SSH access configured (root password set)
- [ ] Network connectivity verified
- [ ] Disk device paths confirmed in `disk-config.nix`
- [ ] `./scripts/deploy.sh <target-ip>` completed successfully
- [ ] System rebooted and accessible

### Post-Migration Verification
- [ ] `nix run github:clan-lol/clan-core -- machines list` shows machine
- [ ] `nix run github:clan-lol/clan-core -- machines status` shows online
- [ ] `nix run github:clan-lol/clan-core -- machines show <machine>` shows correct details
- [ ] Test deployment: `--dry-run` works without errors
- [ ] First Clan deployment successful
- [ ] SSH access works: `ssh w3max@<machine-ip>`

### Advanced Features (Optional)
- [ ] Mesh networking configured between machines
- [ ] Required services enabled (zerotier, backup, monitoring)
- [ ] Secrets management configured
- [ ] Backup strategy implemented
- [ ] Monitoring and alerting set up

## 🤔 When to Use Which Tool

### Use nixos-anywhere (`scripts/deploy.sh`) When:
- ✅ Installing NixOS on fresh/blank machine
- ✅ Hardware detection and configuration needed
- ✅ Initial system bootstrap required
- ✅ Disaster recovery (rebuilding from scratch)
- ✅ Testing new machine configurations

### Use Clan Commands When:
- ✅ Updating existing NixOS machines
- ✅ Managing multiple machines as a fleet
- ✅ Coordinating services across machines
- ✅ Ongoing configuration management
- ✅ Service orchestration and monitoring

## 🚨 Common Migration Issues

### Issue: Clan can't find machine
**Symptoms:** `machines list` doesn't show your machine
```bash
# Check flake configuration
cat nix/clan.nix
# Verify machine is defined in inventory

# Check SSH connectivity
ssh root@<machine-ip>
```

### Issue: Deployment fails after migration
**Symptoms:** Clan deploy command errors
```bash
# Check machine accessibility
nix run github:clan-lol/clan-core -- machines debug-ssh <machine>

# Try with debug output
nix run github:clan-lol/clan-core -- machines deploy <machine> --debug

# Verify target host configuration
nix run github:clan-lol/clan-core -- machines show <machine>
```

### Issue: Services not working
**Symptoms:** Clan services fail to start
```bash
# Check service status
nix run github:clan-lol/clan-core -- services status

# Restart failed services
nix run github:clan-lol/clan-core -- services restart <service-name>

# Re-deploy machine configuration
nix run github:clan-lol/clan-core -- machines deploy <machine>
```

## 🎯 Success Criteria

Your migration is complete when:

1. ✅ Machine appears in `clan machines list`
2. ✅ Machine shows "online" in `clan machines status`
3. ✅ Configuration updates work via `clan machines deploy`
4. ✅ You're no longer using `deploy.sh` for ongoing management
5. ✅ All required services are enabled and working
6. ✅ Multi-machine coordination works (if applicable)

## 📚 Next Steps

After successful migration:

1. **Read the workflows guide:** `docs/CLAN-WORKFLOWS.md`
2. **Set up monitoring:** Enable system health monitoring
3. **Configure backups:** Set up automated backup strategies
4. **Document your setup:** Create runbooks for your specific environment
5. **Plan scaling:** Prepare for adding more machines to your cluster

## 💡 Pro Tips

- **Keep deploy.sh around** - you'll need it for future fresh installations
- **Use VM for testing** - always test configuration changes on the VM first
- **Monitor the first few deployments** - watch for any issues during transition
- **Document custom changes** - note any deviations from standard configuration
- **Set up alerts** - get notified if machines go offline or deployments fail

---

**Remember:** This migration gives you the best of both worlds - reliable initial deployment AND powerful ongoing management! 🚀
