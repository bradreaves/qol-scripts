# Fish Shell Scripts

A collection of useful Fish shell scripts for development workflows.

## Installation

After cloning this repository, run the installation script to set up the scripts:

```bash
fish .install.fish
```

This will:
- Install **worktree** and **mkcd** as Fish functions in `~/.config/fish/functions/` (required because they use `cd` to change directories)
- Make **aicommit** executable (runs as a standalone script - doesn't need to be a function)
- Install fish shell completions for all scripts
- Install git hooks that automatically update Fish functions when you commit or merge to `main`

**Note:** Ensure `~/bin/scripts` is in your PATH for standalone executables like `aicommit` to work.

## Scripts

### worktree (Fish Function)

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

### mkcd (Fish Function)

Create a directory and cd into it in one command.

**Usage:**
```fish
mkcd new-directory
```

### aicommit (Standalone Executable)

Generate AI-powered git commit messages using Claude Code.

**Usage:**
```fish
aicommit
```

## Git Hooks

The repository includes git hooks that automatically keep your Fish functions in sync:

- **post-commit**: Updates Fish functions (worktree, mkcd) and their completions after committing to `main`
- **post-merge**: Updates Fish functions (worktree, mkcd) and their completions after merging into `main`

These hooks are automatically installed when you run `.install.fish`.

## Development

To manually update your Fish functions and completions after making changes:

```fish
fish .install.fish
```

## Requirements

- Fish shell (4.0+)
- Git

## License

Personal scripts - use at your own discretion.
