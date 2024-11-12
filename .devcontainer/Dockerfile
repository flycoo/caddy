FROM mcr.microsoft.com/devcontainers/go:1-1.22-bookworm

# Accept build arguments
ARG LOCAL_USER
ARG LOCAL_UID
ARG DOCKER_GID
ARG HTTP_PROXY
ARG HTTPS_PROXY

# Install necessary tools with proxy settings
RUN apt-get update -o Acquire::http::Proxy="$HTTP_PROXY" && \
    apt-get install -y -o Acquire::http::Proxy="$HTTP_PROXY" dnsutils iputils-ping telnet docker.io

# Create user with the provided name and UID if it doesn't already exist
RUN if id -u $LOCAL_UID >/dev/null 2>&1; then \
    existing_user=$(getent passwd $LOCAL_UID | cut -d: -f1) && \
    usermod -l $LOCAL_USER $existing_user && \
    usermod -d /home/$LOCAL_USER -m $LOCAL_USER && \
    groupmod -n $LOCAL_USER $existing_user; \
    else \
    useradd -m -s /bin/bash -u $LOCAL_UID $LOCAL_USER; \
    fi && \
    usermod -aG sudo $LOCAL_USER && \
    echo "$LOCAL_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure docker group exists and has the correct GID
RUN if ! getent group docker; then groupadd -g $DOCKER_GID docker; fi && \
    if [ $(getent group docker | cut -d: -f3) -ne $DOCKER_GID ]; then groupmod -g $DOCKER_GID docker; fi && \
    usermod -aG docker $LOCAL_USER

CMD ["tail", "-f", "/dev/null"]