# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH
export ANTIGEN_LOG=$HOME/.antigen/log_antigen.log

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history


# Load Antigen
source "$HOME/software/antigen.zsh"

HIST_STAMPS="%d/%m/%y %T"
antigen use oh-my-zsh

source ~/software/zsh-autocomplete/zsh-autocomplete.plugin.zsh


antigen bundles <<EOBUNDLES
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting
	logging
	pip
	command-not-found
	common-aliases
	git-extra-commands
	zsh-navigation-tools
	colored-man-pages
	encode64
	kubectl
	jsontools
	python
	rust
	sudo
	terraform
	systemd
	celery
	docker
	docker-compose
	jira
	alias-finder
	web-search
	systemadmin
	safe-paste
	nmap
	history
	copydir
	copyfile
	ubuntu
	ssh-connect
	thefuck
EOBUNDLES

antigen apply


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

export _ZO_ECHO=1
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

eval "$(zoxide init zsh)"


eval "$(starship init zsh)"
alias ltree="exa --color=always --tree --level=2"
alias ls="exa --color=always"
alias ll="exa --color=always -l"
alias lll="exa --color=always -bghHliS"
eval $(thefuck --alias f)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
