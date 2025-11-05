FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
    base-devel \
    git \
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

WORKDIR /home/developer
USER developer
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_ROOT=/usr/share/dotnet

ENV SHELL=/bin/bash

CMD ["/bin/bash"]
