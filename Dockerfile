FROM archlinux:latest

ARG DEV_PASSWORD=dev

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
    dotnet-sdk \
    openssh

RUN ssh-keygen -A \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

COPY ./config /home/dev/.config
COPY ./setup.sh /setup.sh
RUN chmod +x /setup.sh

RUN useradd -m -u 1000 -s /bin/bash dev \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "dev:${DEV_PASSWORD}" | chpasswd

RUN mv /home/dev/.config/.tmux.conf /home/dev

RUN chown -R dev:dev /home/dev/

RUN mkdir -p /home/dev/.ssh \
    && chown dev:dev /home/dev/.ssh \
    && chmod 700 /home/dev/.ssh

WORKDIR /home/dev
USER dev
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_ROOT=/usr/share/dotnet
ENV SHELL=/bin/bash

EXPOSE 22

CMD ["/bin/bash"]
