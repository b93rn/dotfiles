# Boot ZSH with tmux
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

BROWSER="brave"

# Theme
ZSH_THEME="agnoster"

# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

# Aliases
  alias k="kubectl"
  alias c="code"
  alias g="git"
  alias tb="taskbook"
  alias tel="telepresence"
  alias vim="nvim"
  alias viminit="cd ~/.dotfiles/vim/ && nvim init.vim"
  alias dotfiles="code $HOME/.dotfiles"
  alias kx="kubectx"
  alias projects="cd ~/Documents/projects"
  alias dn="dotnet"
  alias dnrs="dotnet restore"
  alias dnt="dotnet test"
  alias dnwt="dotnet watch test"
  alias dnwr="dotnet watch run"
  alias dnb="dotnet build"
  alias mdf="cd ~/Documents/mdf/ && code \`ls | fzf\`"
  alias mdfv="cd ~/Documents/mdf/ && cd \`ls | fzf\` && vim ."
  alias mdfcd="cd ~/Documents/mdf/ && cd \`ls | fzf\`"
  alias mmll="cd ~/Documents/mdf/mdf-ml && code ."
  alias cf="cd \`ls -d */ | fzf\`"
  alias i3="cd ~/.config/i3/"
  alias sv="source venv/bin/activate && conda deactivate"

# Settings
	export VISUAL=vim
  export ASPNETCORE_ENVIRONMENT="Development"

#Functions
	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output 
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

# Custom cd
  chpwd() ls

# For vim mappings: 
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

plugins=(
  git
  git-flow
  kubectl
  azure
  dotnet
)

for plugin ($plugins); do
    fpath=(~/.dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
done

compinit

source ~/.dotfiles/zsh/plugins/ohmyzsh/lib/history.zsh
source ~/.dotfiles/zsh/plugins/ohmyzsh/lib/key-bindings.zsh
source ~/.dotfiles/zsh/plugins/ohmyzsh/lib/completion.zsh
source ~/.dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.dotfiles/zsh/plugins/kubetail/kubetail.plugin.zsh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
