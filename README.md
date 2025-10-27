# Fish Shell Scripts

A collection of useful Fish shell scripts for development workflows.

## Installation

After cloning this repository, run the installation script to set up the scripts as Fish functions and install git hooks:

```bash
fish .install.fish
```

This will:
- Copy all scripts to `~/.config/fish/functions/` (so they work like native Fish commands)
- Install git hooks that automatically update your Fish functions when you commit or merge to `main`

## Scripts

### worktree

Create and manage git worktrees with automatic directory naming.

**Features:**
- Create worktrees with automatic directory naming (`../repo-branchname`)
- Option to create worktrees in `/tmp`
- Close worktrees with safety checks (ensures commits are pushed or merged)
- Automatic branch cleanup (deletes merged branches)
- Move closed worktrees to trash for recoverability

**Usage:**
```fish
# Create a new worktree
worktree feature-branch

# Create a worktree in /tmp
worktree -t temporary-fix

# Close the current worktree (from inside the worktree)
worktree --close

# Force close without safety checks
worktree --force-close

# Show help
worktree --help

# Show version
worktree --version
```

### mkcd

Create a directory and cd into it in one command.

**Usage:**
```fish
mkcd new-directory
```

### aicommit

AI-powered git commit message generator (if available).

**Usage:**
```fish
aicommit
```

## Git Hooks

The repository includes git hooks that automatically keep your Fish functions in sync:

- **post-commit**: Updates Fish functions after committing to `main`
- **post-merge**: Updates Fish functions after merging into `main`

These hooks are automatically installed when you run `.install.fish`.

## Development

To manually update your Fish functions after making changes:

```fish
fish .install.fish
```

## Requirements

- Fish shell (4.0+)
- Git

## License

Personal scripts - use at your own discretion.
