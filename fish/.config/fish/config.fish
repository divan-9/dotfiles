if status is-interactive
    # Commands to run in interactive sessions can go here
    nvm use lts

    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx DYLD_FALLBACK_LIBRARY_PATH /opt/homebrew/lib

    # Set XDG location of Emacs Spacemacs configuration
    set -gx SPACEMACSDIR "$XDG_CONFIG_HOME/spacemacs"
    fish_add_path /opt/homebrew/bin
end

# source /Users/dmitryivanov/.docker/init-fish.sh || true # Added by Docker Desktop
