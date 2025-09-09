# Efficient Linting Workflow

Instead of the slow `nix flake check`, use these faster commands:

## Quick Linting Commands

```bash
# Enter development shell
nix develop

# Run individual linters (much faster)
pre-commit run shellcheck --all-files      # Check shell scripts
pre-commit run nixfmt-classic --all-files  # Format Nix code
pre-commit run yamllint --all-files        # Check YAML files
pre-commit run trim-trailing-whitespace --all-files  # Fix whitespace
pre-commit run end-of-file-fixer --all-files         # Fix file endings

# Run all pre-commit hooks (faster than flake check)
pre-commit run --all-files

# Run specific hook on staged files only (fastest)
pre-commit run shellcheck
pre-commit run nixfmt-classic
```

## What Each Hook Does

- **nixfmt-classic**: Formats Nix code consistently
- **nix-flake-check**: Validates flake structure (this one is slower)
- **shellcheck**: Lints shell scripts for bugs and style issues
- **yamllint**: Validates YAML syntax
- **check-merge-conflicts**: Finds git merge conflict markers
- **check-symlinks**: Finds broken symbolic links
- **trim-trailing-whitespace**: Removes trailing spaces
- **end-of-file-fixer**: Ensures files end with newlines

## Auto-fixing vs Manual Review

**Auto-fix these** (safe to run):
- `nixfmt-classic` - Nix formatting
- `trim-trailing-whitespace` - Remove trailing spaces
- `end-of-file-fixer` - Add final newlines

**Review these** (may need manual fixes):
- `shellcheck` - Shell script issues
- `yamllint` - YAML syntax problems
- `nix-flake-check` - Flake build issues

## Git Integration

Pre-commit hooks are automatically installed and will run on `git commit`.

To skip hooks for a commit: `git commit -m "message" --no-verify`
