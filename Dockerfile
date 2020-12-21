# Base image
FROM node:15.4.0-alpine

# Exit immediately if a command exits with a non-zero status
RUN set -e

# Install bash
RUN apk add --no-cache \
    bash
ENV PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# Install base dependencies
RUN apk add --no-cache \
    curl \
    git \
    openssh \
    openssl \
    sudo

# Create vscode user
ARG DEVCONTAINER_USERNAME=node
ENV DEVCONTAINER_USERNAME=$DEVCONTAINER_USERNAME
RUN echo $DEVCONTAINER_USERNAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$DEVCONTAINER_USERNAME \
  && chmod 0440 /etc/sudoers.d/$DEVCONTAINER_USERNAME

# Setup VSCode server directories
RUN mkdir -p \
    /home/$DEVCONTAINER_USERNAME/.vscode-server/extensions \
    /home/$DEVCONTAINER_USERNAME/.vscode-server-insiders/extensions \
  && chown -R $DEVCONTAINER_USERNAME \
    /home/$DEVCONTAINER_USERNAME/.vscode-server \
    /home/$DEVCONTAINER_USERNAME/.vscode-server-insiders

# Set user and workdir
USER $DEVCONTAINER_USERNAME
WORKDIR /home/$DEVCONTAINER_USERNAME
