#!/bin/bash

# --- Define Your Scripts Here ---
# FORMAT: "Display Name" = "command_to_run"
TERMINAL="${TERMINAL:-alacritty}"
declare -A options
options["install web app"]="$TERMINAL --class web-app-install -e $HOME/.config/hypr/scripts/web-app-install.sh"

# ----------------------------------

# Generate the menu options for Wofi
menu_options=""
for key in "${!options[@]}"; do
  menu_options+="$key\n"
done

# Show the Wofi menu and capture the user's choice
# The --dmenu flag tells Wofi to work with stdin/stdout
choice=$(echo -e "$menu_options" | wofi --dmenu -p "Scripts" -i)

# Execute the command associated with the chosen option
if [ -n "$choice" ]; then
  command_to_run="${options[$choice]}"
  if [ -n "$command_to_run" ]; then
    # Run the command in the background
    ($command_to_run) &
  else
    wofi -e "Invalid option selected"
  fi
fi
