#!/usr/bin/env bash
set -euo pipefail

# SCRIPT_DIR is the root of the skills directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ordered list of target keys
REGISTERED_TARGETS=("gemini" "oh-my-pi")

# Target registry mapping target identifier to destination directory and description
# Uses functions instead of associative arrays (declare -A) for macOS default Bash 3.2 compatibility
get_target_path() {
    local target="$1"
    case "$target" in
        "gemini")   echo "$HOME/.gemini/config/skills" ;;
        "oh-my-pi") echo "$HOME/.agents/skills" ;;
        *)          return 1 ;;
    esac
}

get_target_description() {
    local target="$1"
    case "$target" in
        "gemini")   echo "Google Antigravity / Gemini CLI (path: ~/.gemini/config/skills)" ;;
        "oh-my-pi") echo "Oh My Pi / omp CLI (path: ~/.agents/skills)" ;;
        *)          return 1 ;;
    esac
}

# Find all valid skills (directories containing SKILL.md)
get_available_skills() {
    local skills=()
    for item in "$SCRIPT_DIR"/*; do
        if [[ -d "$item" && -f "$item/SKILL.md" ]]; then
            skills+=("$(basename "$item")")
        fi
    done
    if [[ ${#skills[@]} -gt 0 ]]; then
        echo "${skills[@]}"
    fi
}

print_usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]

Synchronize agent skills from this directory to installed AI agent harnesses.

Targets:
  all         Sync skills to all registered targets (default)
  gemini      Sync to Google Antigravity / Gemini CLI (~/.gemini/config/skills)
  oh-my-pi    Sync to Oh My Pi CLI (~/.agents/skills)

Options:
  --list      List all registered sync targets and available skills
  -n, --dry-run
              Preview symlinks without modifying the filesystem
  -h, --help  Show this help message

Examples:
  $(basename "$0") --list
  $(basename "$0") --dry-run
  $(basename "$0") gemini
  $(basename "$0") all
EOF
}

list_targets() {
    echo "Registered Sync Targets:"
    for target in "${REGISTERED_TARGETS[@]}"; do
        local desc dest
        desc="$(get_target_description "$target")"
        dest="$(get_target_path "$target")"
        printf "  - %-12s : %s\n" "$target" "$desc"
        printf "    Destination  : %s\n" "$dest"
    done
    echo
    echo "Available Skills:"
    local skills=($(get_available_skills))
    if [[ ${#skills[@]} -eq 0 ]]; then
        echo "  (No skills found with a SKILL.md file)"
    else
        for skill in "${skills[@]}"; do
            echo "  - $skill"
        done
    fi
}

sync_target() {
    local target="$1"
    local dry_run="$2"
    local dest_dir
    local desc
    dest_dir="$(get_target_path "$target")" || {
        echo "Error: Unknown target '$target'" >&2
        return 1
    }
    desc="$(get_target_description "$target")"

    echo "==> Target: $target ($desc)"

    local skills=($(get_available_skills))
    if [[ ${#skills[@]} -eq 0 ]]; then
        echo "    No skills found to synchronize."
        return 0
    fi

    if [[ "$dry_run" == "true" ]]; then
        echo "    [Dry-run] Would ensure destination directory exists: $dest_dir"
    else
        mkdir -p "$dest_dir"
    fi

    for skill in "${skills[@]}"; do
        local source_path="$SCRIPT_DIR/$skill"
        local link_path="$dest_dir/$skill"

        if [[ "$dry_run" == "true" ]]; then
            echo "    [Dry-run] ln -sfn \"$source_path\" \"$link_path\""
        else
            ln -sfn "$source_path" "$link_path"
            echo "    ✓ Linked $skill -> $link_path"
        fi
    done
    echo
}

main() {
    local dry_run="false"
    local selected_target="all"

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --list)
                list_targets
                exit 0
                ;;
            -n|--dry-run)
                dry_run="true"
                shift
                ;;
            -h|--help)
                print_usage
                exit 0
                ;;
            *)
                selected_target="$1"
                shift
                ;;
        esac
    done

    if [[ "$selected_target" == "all" ]]; then
        for target in "${REGISTERED_TARGETS[@]}"; do
            sync_target "$target" "$dry_run"
        done
    elif get_target_path "$selected_target" >/dev/null 2>&1; then
        sync_target "$selected_target" "$dry_run"
    else
        echo "Error: Unknown target '$selected_target'" >&2
        echo >&2
        print_usage >&2
        exit 1
    fi

    if [[ "$dry_run" == "true" ]]; then
        echo "Dry-run complete. No filesystem changes made."
    else
        echo "Synchronization complete."
    fi
}

main "$@"
