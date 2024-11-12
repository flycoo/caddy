services:
  devcontainer:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        LOCAL_USER: ${LOCAL_USER}
        LOCAL_UID: ${LOCAL_UID}
        DOCKER_GID: ${DOCKER_GID}
        HTTP_PROXY: ${HTTP_PROXY}
        HTTPS_PROXY: ${HTTPS_PROXY}
    environment:
      https_proxy: "${HTTPS_PROXY}"
      http_proxy: "${HTTP_PROXY}"
    network_mode: default
    dns:
      - 10.0.0.1
