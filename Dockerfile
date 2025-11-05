FROM archlinux:latest

# Disable SSL certificate verification for pacman
# The corporate overlords, for security purposes, have a self signed certificate on the vpn that breaks things
# So we have to disable security to get around security...
RUN echo "XferCommand = /usr/bin/curl -L -C - -f -o %o %u --insecure" >> /etc/pacman.conf

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
    base-devel \
    git \
    less \
    wget \
    unzip \
    ripgrep \
    gcc \
    make \
    fd \
    curl \
    tmux \
    neovim \
    github-cli \
    dotnet-sdk-8.0 \
    dotnet-sdk

COPY ./config /home/developer/.config

RUN useradd -m -u 1000 -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R developer:developer /home/developer/

## configure tmux
RUN mv /home/developer/.config/.tmux.conf /home/developer
RUN git clone https://github.com/tmux-plugins/tpm /home/developer/.tmux/plugins/tpm

## git config
### Because the files are actually on the host and in windows this can be a problem
### https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou
RUN git config --global safe.directory '*'
### Basically, do not track line endings
RUN git config --global core.autocrlf false

WORKDIR /home/developer
USER developer
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_ROOT=/usr/share/dotnet
export ASPNETCORE_ENVIRONMENT=Development

ENV SHELL=/bin/bash

CMD ["/bin/bash"]
