#!/usr/bin/env fish

# Installation script for fish shell scripts
# This installs the scripts as fish functions and sets up git hooks

echo "Installing fish shell scripts..."
echo ""

# Ensure directories exist
mkdir -p ~/.config/fish/functions
mkdir -p ~/.config/fish/completions

# Install fish functions (scripts that need to modify shell state)
echo "Installing functions to ~/.config/fish/functions/..."

for script in worktree mkcd
    if test -f $script
        # Install function
        cp $script ~/.config/fish/functions/$script.fish
        and echo "  ✓ Installed $script.fish"
        or echo "  ✗ Failed to install $script.fish"

        # Install completions
        set completions_file ~/.config/fish/completions/$script.fish
        if test -f "$completions_file"
            rm "$completions_file"
        end

        fish $script --fish-completions >/dev/null 2>&1
        and echo "  ✓ Installed completions for $script"
        or echo "  ℹ No completions for $script"
    else
        echo "  ✗ $script script not found"
    end
end

echo ""
echo "Installing standalone executables..."

# Install standalone scripts (don't need to modify shell state)
for script in aicommit
    if test -f $script
        # Make executable
        chmod +x $script
        and echo "  ✓ $script is executable"
        or echo "  ✗ Failed to make $script executable"

        # Install completions
        set completions_file ~/.config/fish/completions/$script.fish
        if test -f "$completions_file"
            rm "$completions_file"
        end

        ./$script --fish-completions >/dev/null 2>&1
        and echo "  ✓ Installed completions for $script"
        or echo "  ℹ No completions for $script"
    else
        echo "  ✗ $script script not found"
    end
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
