#!/bin/bash
if [ ! -f /home/dev/.dockerdev_setup_complete ]; then
    git config --global safe.directory '*'
    git config --global core.autocrlf input
    
    # setup zoxide for bash
    # probably move this to a .bashrc file to copy over
    # since this is the only config it is fine for now
    echo 'eval "$(zoxide init --cmd cd bash)"' >> ~/.bashrc
    echo 'eval "$(zoxide init --cmd cd bash)"' >> /home/dev/.bash_profile

    dotnet workload update

    touch /home/dev/.dockerdev_setup_complete
    sudo /usr/bin/sshd
    echo "First time setup complete."
fi

exec "$@"