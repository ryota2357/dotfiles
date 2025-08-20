complete \
    --command tmux-connect \
    --no-files

# --paths
complete \
    --command tmux-connect \
    --long-option 'paths' \
    --short-option 'p' \
    --description "Comma-separated list of paths to the tmux command" \
    --require-parameter

# --help
complete \
    --command tmux-connect \
    --long-option 'help' \
    --short-option 'h' \
    --description "Display help message"
