// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/go
{
	"name": "<Project Name-生成时替换>",
	"dockerComposeFile": "docker-compose.yml",
	"service": "devcontainer",
	"workspaceFolder": "/workspace",
	"customizations": {
		"vscode": {
			"settings": {
				"http.proxy": "http://squid:3128",
				"http.proxyStrictSSL": false // 如果你的代理服务器使用的是自签名证书，需要将此设置为false
			},
			"extensions": [
				"ms-azuretools.vscode-docker",
				"mhutchie.git-graph",
				"donjayamanne.githistory",
				"eamodio.gitlens",
				"waderyan.gitblame",
				"donjayamanne.git-extension-pack",
				"GitHub.copilot-chat",
				"golang.go"
			]
		}
	},

	"initializeCommand": "if [ ! -f .devcontainer/.env ]; then touch .devcontainer/.env; fi; if ! grep -q 'LOCAL_USER' .devcontainer/.env; then echo 'LOCAL_USER=${localEnv:USER}' >> .devcontainer/.env; fi; if ! grep -q 'LOCAL_UID' .devcontainer/.env; then echo LOCAL_UID=$(id -u ${localEnv:USER}) >> .devcontainer/.env; fi; if ! grep -q 'DOCKER_GID' .devcontainer/.env; then echo DOCKER_GID=$(stat -c '%g' /var/run/docker.sock) >> .devcontainer/.env; fi; if ! grep -q 'HTTP_PROXY' .devcontainer/.env; then http_proxy_ip=$(getent hosts squid | awk '{ print $1 }') && echo HTTP_PROXY=http://$http_proxy_ip:3128 >> .devcontainer/.env; fi; if ! grep -q 'HTTPS_PROXY' .devcontainer/.env; then https_proxy_ip=$(getent hosts squid | awk '{ print $1 }') && echo HTTPS_PROXY=http://$https_proxy_ip:3128 >> .devcontainer/.env; fi",

	"mounts": [
		"source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind",
		"source=../,target=/workspace,type=bind,consistency=cached",
		"source=/home/${localEnv:USER}/.ssh,target=/home/${localEnv:USER}/.ssh,type=bind,readonly"
	],

	"remoteUser": "${localEnv:USER}"
}
