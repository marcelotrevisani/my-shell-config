#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y \
	fonts-firacode \
	zsh \
	zsh-common \
	zsh-antigen \
	fonts-powerline \
	zsh-autosuggestions \
	net-tools \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	fzf \
	cargo \
	git

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	
## starship installation
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "
export ZSH="/home/bb8/.oh-my-zsh"

HIST_STAMPS="%d/%m/%y %T"

source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle pip \
	command-not-found \
	common-aliases \
	git-extra-commands \
	zsh-navigation-tools \
	colored-man-pages \
	django \
	encode64 \
	kubectl \
	jsontools \
	python \
	rust \
	sudo \
	terraform \
	systemd \
	celery \
	cargo \
	docker \
	docker-compose \
	jira \
	alias-finder \
	web-search \
	systemadmin \
	safe-paste \
	rustup \
	per-directory-history \
	nmap \
	history \
	copydir \
	copyfile \
	ubuntu \
	z
antigen apply


plugins=(
#        z
	gitfast
	zsh-autosuggestions
	zsh-syntax-highlighting
	pip
	command-not-found
	common-aliases
	git-extras
	zsh-navigation-tools
	colored-man-pages
	django
	encode64
	kubectl
	jsontools
	python
	rust
	sudo
	terraform
	systemd
	celery
	cargo
	docker
	docker-compose
	jira
	alias-finder
	web-search
	systemadmin
	safe-paste
	rustup
#	per-directory-history
	nmap
	history
	copydir
	copyfile
	ubuntu
#	auto-ls
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
ZSH_AUTOSUGGEST_USE_ASYNC=1

export _ZO_ECHO=1
export FZF_DEFAULT_COMMAND=\"fd --type file --color=always\"
export FZF_DEFAULT_OPTS=\"--ansi\"
eval \"$(zoxide init zsh)\"

# git alias to squash all commits on a branch into a single one
alias squash-all=\"git reset $(git merge-base master $(git rev-parse --abbrev-ref HEAD))\"


# starship
eval \"$(starship init zsh)\"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
" > ~/.zshrc


# bottom
rustup update stable
cargo install bottom

# tealdeer
cargo install tealdeer
tldr --update

# grex
cargo install grex


# bandwhich
cargo install bandwhich
sudo ln -s ~/.cargo/bin/bandwhich /usr/local/bin/

# tokei
cargo install tokei

# ripgrep
cargo install ripgrep

# dust
cargo install du-dust

# sd
cargo install sd

# procs
cargo install procs

# fd
cargo install fd-find

# exa
cargo install exa
ln -s ~/.cargo/bin/exa ~/.local/bin/ls

# bat
cargo install bat
ln -s ~/.cargo/bin/bat ~/.local/bin/cat

# zoxide
cargo install zoxide

# xxh portable version
mkdir ~/xxh && pushd ~/xxh
wget https://github.com/xxh/xxh/releases/download/0.8.7/xxh-portable-musl-alpine-Linux-x86_64.tar.gz
tar -xzf xxh-portable-musl-alpine-Linux-x86_64.tar.gz


# starship config
echo "[conda]
ignore_base = false

[docker_context]
disabled = false

[kubernetes]
disabled = false

[memory_usage]
disabled = false
threshold = -1
format=\"via $symbol [${ram}]($style) \"

[shell]
disabled = false

[username]
show_always = true

[cmd_duration]
show_notifications = true
min_time = 0
min_time_to_notify = 500

[git_branch]
always_show_remote = true

[git_commit]
tag_disabled = false" > ~/.config/starship.toml


## docker installation
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo groupadd docker
sudo usermod -aG docker $USER

sudo touch /etc/docker/daemon.json
sudo echo '                                                                                       
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
' > /etc/docker/daemon.json

## end docker installation

## Kubernetes installation
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl kubeadm

source ~/.zshrc
