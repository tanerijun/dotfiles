#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/Projects/dotfiles"

mkdir -p "$DOTFILES_DIR"

echo "=== Dotfiles Backup Script ==="
echo "Config directory: $CONFIG_DIR"
echo "Backup location: $DOTFILES_DIR"
echo

# Get all directories in .config
available_dirs=($(find "$CONFIG_DIR" -maxdepth 1 -type d -not -path "$CONFIG_DIR" -exec basename {} \; | sort))

if [ ${#available_dirs[@]} -eq 0 ]; then
    echo "No directories found in $CONFIG_DIR"
    exit 1
fi

echo "Available directories in .config:"
for i in "${!available_dirs[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${available_dirs[$i]}"
done

echo
echo "Select directories to backup:"
echo "Enter numbers separated by spaces (e.g., 1 3 5)"
echo "Or type 'all' to backup everything"
echo "Or type 'q' to quit"

read -p "Your selection: " selection

# Handle quit
if [[ "$selection" == "q" ]]; then
    echo "Backup cancelled."
    exit 0
fi

# Handle all
if [[ "$selection" == "all" ]]; then
    selected_dirs=("${available_dirs[@]}")
else
    # Parse individual selections
    selected_dirs=()
    for num in $selection; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#available_dirs[@]} ]; then
            selected_dirs+=("${available_dirs[$((num-1))]}")
        else
            echo "Invalid selection: $num (ignoring)"
        fi
    done
fi

if [ ${#selected_dirs[@]} -eq 0 ]; then
    echo "No valid directories selected. Exiting."
    exit 1
fi

echo
echo "Selected directories for backup:"
printf " - %s\n" "${selected_dirs[@]}"
echo

read -p "Continue with backup? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Backup cancelled."
    exit 0
fi

echo
echo "Starting backup..."

for dir in "${selected_dirs[@]}"; do
    if [ -d "$CONFIG_DIR/$dir" ]; then
        echo "Backing up $dir..."

        # Remove existing directory in dotfiles if it exists
        if [ -d "$DOTFILES_DIR/$dir" ]; then
            rm -rf "$DOTFILES_DIR/$dir"
            echo "  Removed existing $dir"
        fi

        # Copy the directory
        cp -r "$CONFIG_DIR/$dir" "$DOTFILES_DIR/"
        echo "  ✓ $dir backed up successfully"
    else
        echo "  ⚠ $dir not found, skipping"
    fi
done

echo
echo "🎉 Backup complete!"
echo "Location: $DOTFILES_DIR"
