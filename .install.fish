#!/usr/bin/env fish

# Installation script for fish shell scripts
# This installs the scripts as fish functions and sets up git hooks

echo "Installing fish shell scripts..."
echo ""

# Ensure fish functions directory exists
mkdir -p ~/.config/fish/functions

# Copy scripts to fish functions
echo "Installing functions to ~/.config/fish/functions/..."

if test -f worktree
    cp worktree ~/.config/fish/functions/worktree.fish
    and echo "  ✓ Installed worktree.fish"
    or echo "  ✗ Failed to install worktree.fish"
else
    echo "  ✗ worktree script not found"
end

if test -f mkcd
    cp mkcd ~/.config/fish/functions/mkcd.fish
    and echo "  ✓ Installed mkcd.fish"
    or echo "  ✗ Failed to install mkcd.fish"
end

if test -f aicommit
    cp aicommit ~/.config/fish/functions/aicommit.fish
    and echo "  ✓ Installed aicommit.fish"
    or echo "  ✗ Failed to install aicommit.fish"
end

echo ""
echo "Installing git hooks..."

# Check if we're in a git repository
if not test -d .git
    echo "  ✗ Not in a git repository - skipping hook installation"
    echo ""
    echo "Installation complete (functions only)!"
    exit 0
end

# Copy hooks to .git/hooks/
if test -f .hooks/post-commit
    cp .hooks/post-commit .git/hooks/post-commit
    chmod +x .git/hooks/post-commit
    and echo "  ✓ Installed post-commit hook"
    or echo "  ✗ Failed to install post-commit hook"
end

if test -f .hooks/post-merge
    cp .hooks/post-merge .git/hooks/post-merge
    chmod +x .git/hooks/post-merge
    and echo "  ✓ Installed post-merge hook"
    or echo "  ✗ Failed to install post-merge hook"
end

echo ""
echo "Installation complete!"
echo ""
echo "The hooks will automatically update your fish functions when you:"
echo "  - Commit to the main branch"
echo "  - Merge into the main branch"
