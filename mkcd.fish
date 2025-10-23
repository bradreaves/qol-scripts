#!/usr/bin/env fish

# Function: mkcd
# Version: 1.0.0
# Description: Create a directory (with parents) and cd into it

set -g MKCD_VERSION "1.0.0"

function mkcd --description "Create a directory and cd into it"
    set SCRIPT_NAME "mkcd"

    function log_info
        logger -t "$SCRIPT_NAME[$fish_pid]" -p user.info $argv
    end

    function log_error
        logger -t "$SCRIPT_NAME[$fish_pid]" -p user.error $argv
    end

    function log_warning
        logger -t "$SCRIPT_NAME[$fish_pid]" -p user.warning $argv
    end

    function log_debug
        logger -t "$SCRIPT_NAME[$fish_pid]" -p user.debug $argv
    end

    function show_version
        echo "mkcd version $MKCD_VERSION"
        return 0
    end

    function show_help
        echo "Usage: mkcd [options] DIRECTORY"
        echo ""
        echo "Create a directory (including parent directories) and cd into it."
        echo ""
        echo "Arguments:"
        echo "  DIRECTORY        Directory path to create (use quotes for spaces)"
        echo ""
        echo "Options:"
        echo "  -h, --help       Show this help message"
        echo "  -v, --version    Show version information"
        echo ""
        echo "Examples:"
        echo "  mkcd foo/bar/baz          # Creates nested directories"
        echo "  mkcd \"my project\"          # Creates directory with spaces"
        echo "  mkcd ~/projects/new       # Creates in home directory"
        return 0
    end

    # Parse arguments
    argparse 'h/help' 'v/version' -- $argv
    or begin
        show_help
        return 1
    end

    if set -q _flag_help
        show_help
        return 0
    end

    if set -q _flag_version
        show_version
        return 0
    end

    # Check if directory argument is provided
    if test (count $argv) -eq 0
        log_error "action=validate error=\"no directory specified\""
        echo "Error: No directory specified" >&2
        echo "Use 'mkcd --help' for usage information" >&2
        return 1
    end

    # Check if too many arguments
    if test (count $argv) -gt 1
        log_error "action=validate error=\"too many arguments\""
        echo "Error: Too many arguments. Use quotes for directory names with spaces." >&2
        echo "Example: mkcd \"my directory\"" >&2
        return 1
    end

    set target_dir $argv[1]

    # Validate directory name is not empty after trimming
    if test -z "$target_dir"
        log_error "action=validate error=\"empty directory name\""
        echo "Error: Directory name cannot be empty" >&2
        return 1
    end

    # Check if directory already exists
    if test -d "$target_dir"
        log_warning "action=create status=\"already exists\" dir=\"$target_dir\""
        echo "Warning: Directory already exists: $target_dir" >&2
        log_info "action=change_dir dir=\"$target_dir\""
        cd "$target_dir"
        return 0
    end

    # Create the directory with parent directories
    log_info "action=create dir=\"$target_dir\""
    if mkdir -p "$target_dir"
        log_info "action=create status=success dir=\"$target_dir\""
        log_info "action=change_dir dir=\"$target_dir\""
        cd "$target_dir"
        return 0
    else
        set exit_code $status
        log_error "action=create status=failed dir=\"$target_dir\" exit_code=$exit_code"
        echo "Error: Failed to create directory: $target_dir" >&2
        return $exit_code
    end
end
