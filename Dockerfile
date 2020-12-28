# Base image
FROM node:15.5.0-buster-slim

# Exit immediately if a command exits with a non-zero status
RUN set -e

# Install base dependencies
RUN apt-get update && \
  apt-get install -y \
    curl \
    git \
    openssl \
    sudo

# Install project's dependencies
RUN apt-get update && \
  apt-get install -y \
    graphviz

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
