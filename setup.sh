#!/bin/bash
if [ ! -f /home/dev/.dockerdev_setup_complete ]; then
    git config --global safe.directory '*'
    git config --global core.autocrlf input
    git clone https://github.com/tmux-plugins/tpm /home/dev/.tmux/plugins/tpm/

    dotnet workload update

    touch /home/dev/.dockerdev_setup_complete
    sudo /usr/bin/sshd
    echo "First time setup complete."
fi

exec "$@"