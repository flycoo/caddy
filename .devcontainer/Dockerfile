FROM mcr.microsoft.com/devcontainers/go:1-1.22-bookworm

# Accept build arguments
ARG LOCAL_USER
ARG DOCKER_GID

# Install necessary tools
RUN apt-get update && apt-get install -y dnsutils iputils-ping telnet docker.io

# Create user with the provided name
RUN useradd -m -s /bin/bash $LOCAL_USER && \
    usermod -aG sudo $LOCAL_USER && \
    echo "$LOCAL_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure docker group exists and has the correct GID
RUN if ! getent group docker; then groupadd -g $DOCKER_GID docker; fi && \
    if [ $(getent group docker | cut -d: -f3) -ne $DOCKER_GID ]; then groupmod -g $DOCKER_GID docker; fi && \
    usermod -aG docker $LOCAL_USER

# Set the user to the newly created user
# USER $LOCAL_USER

# # Install VS Code extensions
# RUN code --install-extension ms-azuretools.vscode-docker \
#     && code --install-extension mhutchie.git-graph \
#     && code --install-extension donjayamanne.githistory \
#     && code --install-extension eamodio.gitlens \
#     && code --install-extension waderyan.gitblame \
#     && code --install-extension donjayamanne.git-extension-pack \
#     && code --install-extension GitHub.copilot-chat \
#     && code --install-extension golang.go
CMD ["tail", "-f", "/dev/null"]