# Development Workflow

This document covers the development tools and workflows for maintaining this
NixOS configuration.

## Pre-commit Hooks & Code Quality

### Overview

We use comprehensive pre-commit hooks to ensure code quality, security, and
consistency across the entire codebase.

### Installed Hooks

| Hook                       | Purpose                       | Auto-Fix | Speed |
| -------------------------- | ----------------------------- | -------- | ----- |
| `nixfmt-classic`           | Nix code formatting           | ✅       | Fast  |
| `nix-flake-check`          | Flake validation & build      | ❌       | Slow  |
| `shellcheck`               | Shell script linting          | ❌       | Fast  |
| `yamllint`                 | YAML validation               | ❌       | Fast  |
| `check-merge-conflicts`    | Git conflict detection        | ❌       | Fast  |
| `check-symlinks`           | Broken symlink detection      | ❌       | Fast  |
| `trim-trailing-whitespace` | Remove trailing spaces        | ✅       | Fast  |
| `end-of-file-fixer`        | Ensure files end with newline | ✅       | Fast  |

### Quick Commands

```bash
# Enter development shell
nix develop

# Fast individual linting
pre-commit run shellcheck --all-files
pre-commit run nixfmt-classic --all-files
pre-commit run yamllint --all-files

# Run all hooks (faster than nix flake check)
pre-commit run --all-files

# Run on staged files only (fastest)
pre-commit run

# Skip hooks for emergency commits
git commit --no-verify -m "emergency fix"
```

### Development Shell

The development shell includes:

- `nixfmt-classic` - Nix formatter
- `nix` - Nix package manager
- `git` - Version control
- `pre-commit` - Hook runner
- Clan CLI (via `nix run github:clan-lol/clan-core`)

```bash
# Enter development environment
nix develop

# Development shell is automatically configured with pre-commit
```

### Performance Tips

**Fastest workflow:**

1. `nix develop` (one time)
2. `pre-commit run <specific-hook>` (as needed)
3. `pre-commit run --all-files` (before commits)

**Avoid:**

- `nix flake check` for routine linting (very slow)
- Running all hooks when only specific files changed

## Shell Script Quality

### Standards Enforced

All shell scripts now pass `shellcheck` with these improvements:

- Proper variable quoting: `"$variable"` instead of `$variable`
- Modern command usage: `pgrep` instead of `ps | grep`
- Eliminated unused variables and functions
- Fixed array assignments and conditional syntax
- Proper error handling and exit codes

### Excluded Files

These files are excluded from shellcheck for valid reasons:

- `modules/home/p10k/.p10k.zsh` - Powerlevel10k config uses zsh-specific syntax

### Script Categories

1. **System Scripts** (`scripts/`): Deployment and installation
2. **User Scripts** (`modules/home/scripts/`): Desktop utilities
3. **Configuration Scripts**: Hyprland, shell setup

All scripts are now secure, consistent, and maintainable.

## Configuration Organization

### Module Structure

```
modules/
├── common.nix              # Base system (all machines)
├── desktop.nix             # Desktop environment
├── development.nix         # Development tools
├── gaming.nix              # Gaming setup
├── core/                   # Individual system modules
│   ├── secrets.nix         # Secret management
│   ├── security.nix        # Security hardening
│   ├── network.nix         # Network configuration
│   └── ...
└── home/                   # Home manager modules
    ├── scripts/            # User scripts
    ├── hyprland/           # Window manager
    └── ...
```

### Machine-Specific Configs

```
machines/
├── desktop/                # Desktop workstation
└── w3max-workstation/      # High-end gaming/dev station
```

Each machine:

- Imports appropriate module groups
- Has machine-specific settings
- Deploys its secret decryption key
- Includes hardware configuration

## Testing & Validation

### Build Testing

```bash
# Test specific machine build
nix build .#nixosConfigurations.desktop.config.system.build.toplevel

# Test all machines
nix flake check

# Quick syntax check
pre-commit run nixfmt-classic --all-files
```

### Deployment Testing

````bash
# Test deployment without applying
nixos-rebuild dry-build --flake .#hostname

### Secret Testing

```bash
# Verify secret access
nix run github:clan-lol/clan-core -- secrets list

# Test secret decryption
nix run github:clan-lol/clan-core -- secrets get test-secret
````

## Contributing Guidelines

1. **Always use pre-commit hooks**: `pre-commit run --all-files`
2. **Test builds**: Ensure configurations build successfully
3. **Follow module patterns**: Use existing module structure
4. **Document changes**: Update relevant documentation
5. **Secure by default**: Use secrets for sensitive data

## Troubleshooting

### Common Issues

**Pre-commit hooks failing:**

```bash
# Fix formatting issues
pre-commit run --all-files
git add .
git commit -m "fix formatting"
```

**Flake check slow:**

```bash
# Use faster alternatives
pre-commit run --all-files
# OR test specific outputs
nix build .#nixosConfigurations.desktop.config.system.build.toplevel
```

**Secret access denied:**

```bash
# Verify your admin key
ls ~/.config/sops/age/keys.txt
# Verify machine is added
nix run github:clan-lol/clan-core -- secrets machines list
```
