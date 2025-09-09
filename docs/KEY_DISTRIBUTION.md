# Private Key Distribution Guide

## Overview

Your NixOS configuration now uses secure secret management with SOPS and AGE
encryption. Private keys have been removed from the repository and need to be
manually deployed to each machine.

## Key Locations

### New Private Keys

Located in: `~/nixos-private-keys-new/`

- `desktop.key` - For desktop machine
- `w3max-workstation.key` - For workstation machine
- `w3max.key` - Admin key (for manual secret management)

### Backup of Old Keys

Located in: `~/nixos-private-keys-backup/` (These are the original keys - keep
them safe until migration is complete)

## Deployment Instructions

### For Each Machine:

1. **Copy the key to the machine** (choose one method):

   **Option A: Physical Access**
   ```bash
   # On the target machine
   sudo mkdir -p /var/lib/sops-nix
   # Copy key from USB drive or other media
   sudo cp /path/to/[machine].key /var/lib/sops-nix/key.txt
   ```

   **Option B: Via SSH from this machine**
   ```bash
   # Replace [machine] with actual hostname
   scp ~/nixos-private-keys-new/[machine].key user@[machine]:/tmp/machine.key
   ssh user@[machine] 'sudo mkdir -p /var/lib/sops-nix && sudo mv /tmp/machine.key /var/lib/sops-nix/key.txt'
   ```

   **Option C: Using wormhole-william (secure one-time transfer)**
   ```bash
   # On source machine
   nix-shell -p wormhole-william
   wormhole send ~/nixos-private-keys-new/[machine].key

   # On target machine
   nix-shell -p wormhole-william
   wormhole receive [code]
   sudo mkdir -p /var/lib/sops-nix
   sudo mv [machine].key /var/lib/sops-nix/key.txt
   ```

2. **Set correct permissions**:
   ```bash
   sudo chmod 600 /var/lib/sops-nix/key.txt
   sudo chown root:root /var/lib/sops-nix/key.txt
   ```

3. **Rebuild NixOS configuration**:
   ```bash
   sudo nixos-rebuild switch --flake /path/to/nixos-config#[machine]
   ```

## Machine-Specific Keys

| Machine           | Public Key                                                     | Private Key Location                           |
| ----------------- | -------------------------------------------------------------- | ---------------------------------------------- |
| desktop           | age1ll33dvms7wzvzhu9na50d9gawwtctr766mcndmdh3kxy8qqvmvxqeqjqw5 | ~/nixos-private-keys-new/desktop.key           |
| w3max-workstation | age1220h0yey8y6g8esf73fccpw0qwtmh43005ewl5dkjwf3ct2y25xsnwm3x2 | ~/nixos-private-keys-new/w3max-workstation.key |
| admin (w3max)     | age1drplmvrk3sd89e8gedxenyt3dwtrefcv0mcuvl3xy0qv3ugrzcfqna6xzf | ~/nixos-private-keys-new/w3max.key             |

## Security Best Practices

1. **Never commit private keys to git**
2. **Delete keys from /tmp after copying**
3. **Use encrypted USB drives for physical transfer**
4. **Consider using a password manager (Bitwarden) for backup**
5. **Verify file permissions are 600 (read/write for owner only)**

## Verification

After deployment, verify that secrets are accessible:

```bash
# On the target machine
sudo cat /var/lib/sops-nix/key.txt | head -1
# Should show: # created: [date]

# Test secret decryption (after rebuild)
sudo cat /run/secrets/user-password
# Should show the decrypted password
```

## Troubleshooting

If secrets fail to decrypt:

1. Check key file exists: `ls -la /var/lib/sops-nix/key.txt`
2. Verify permissions: should be `-rw------- 1 root root`
3. Check sops can decrypt:
   `nix-shell -p sops --run "SOPS_AGE_KEY_FILE=/var/lib/sops-nix/key.txt sops -d /path/to/secret.yaml"`
4. Ensure the correct key is deployed for the machine

## Important Notes

- Each machine needs its own specific key
- The admin key (w3max.key) can decrypt all secrets but shouldn't be on machines
- Keep backups of all private keys in a secure location
- Keys are generated using age-keygen and are X25519 keys
