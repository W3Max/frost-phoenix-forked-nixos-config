# Security & Secret Management

This NixOS configuration implements robust security measures using Clan's
built-in secret management system.

## Secret Management with Clan

### Overview

We use **Clan's native age-encrypted secret management** instead of standalone
sops-nix for better integration and unified management.

### Architecture

```
sops/
├── users/w3max/key.json          # Admin user public age key
├── machines/                     # Machine-specific public age keys
│   ├── desktop/key.json
│   └── w3max-workstation/key.json
├── secrets/                      # Encrypted secret files
│   ├── user-password.yaml
│   └── ssh-host-keys.yaml
└── .sops.yaml                    # SOPS configuration

/var/lib/sops-nix/key.txt         # Private key location on each machine (NOT in repo)
```

### Key Components

1. **Age Encryption**: Uses modern age encryption with per-machine keys
2. **Machine-Specific Access**: Each machine has its own decryption key
3. **Secure Key Storage**: Private keys stored at `/var/lib/sops-nix/key.txt` on
   each machine
4. **Clan Integration**: Managed through Clan commands, not manual sops

### Available Secrets

| Secret          | File                 | Purpose                |
| --------------- | -------------------- | ---------------------- |
| `user-password` | `user-password.yaml` | User account passwords |
| `ssh-host-key`  | `ssh-host-keys.yaml` | VPN private keys       |
| `github-token`  | `api-tokens.yaml`    | GitHub API access      |

## Usage

### Admin Operations

```bash
# List all secrets
nix run github:clan-lol/clan-core -- secrets list

# View a secret (requires admin key)
nix run github:clan-lol/clan-core -- secrets get user-password

# Add new secret
nix run github:clan-lol/clan-core -- secrets set new-secret

# Add user to secret access
nix run github:clan-lol/clan-core -- secrets users add username --age-key <public-key>
```

### Machine Management

```bash
# List machines with secret access
nix run github:clan-lol/clan-core -- secrets machines list

# Add machine to secrets
nix run github:clan-lol/clan-core -- secrets machines add machine-name <age-public-key>
```

### In NixOS Configuration

Secrets are automatically available in configurations via:

```nix
# Reference secrets in your configuration
config.sops.secrets.user-password.path
config.sops.secrets.ssh-host-key.path
config.sops.secrets.github-token.path
```

## Security Features

- **Age Encryption**: Modern, secure encryption
- **Per-Machine Keys**: Each machine can only decrypt its authorized secrets
- **No Plaintext Storage**: All secrets encrypted at rest
- **Automatic Key Deployment**: Keys deployed securely via Nix build
- **Access Control**: User and machine-level permissions

## Key Management

### Private Key Deployment

Private keys must be manually deployed to each machine. See
[KEY_DISTRIBUTION.md](./KEY_DISTRIBUTION.md) for detailed instructions.

⚠️ **Critical**:

- Private keys are **NOT** stored in the repository
- Each machine's private key must be placed at `/var/lib/sops-nix/key.txt`
- Keep secure backups of all private keys
- Without these keys, you'll lose access to all secrets

## Integration with Applications

The secret management integrates with:

- SSH daemon (host keys)
- User authentication (password hashes)
