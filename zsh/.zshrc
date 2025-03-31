# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Browser
BROWSER="arc"

# History settings
HISTFILE=~/.zsh_history
SAVEHIST=1000
setopt inc_append_history # To save every command before it is executed
setopt share_history      # setopt inc_append_history

# Custom paths
MDF_CODE="~/Documents/Mydatafactory/code/"

# Environment variables
export VISUAL=vim
export ASPNETCORE_ENVIRONMENT="Development"

# For vim mappings
stty -ixon

# Custom cd function
chpwd() ls

# Define plugins - these are loaded by oh-my-zsh
plugins=(
  git            # Git integration and aliases
  git-flow       # Git-flow completion and aliases
  kubectl        # Kubectl autocompletion and aliases
  azure          # Azure CLI helpers
  dotnet         # .NET Core aliases and completion
  zsh-autosuggestions # Command suggestions as you type
  kube-ps1       # Kubernetes prompt integration
)

# Source Oh My Zsh - this loads all the plugins defined above
source $ZSH/oh-my-zsh.sh

# NVM (Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Aliases
alias k="kubectl"
alias c="cursor"
alias g="git"
alias tb="taskbook"
alias tel="telepresence"
alias vim="nvim"
alias viminit="cd ~/.dotfiles/vim/ && nvim init.vim"
alias dotfiles="c $HOME/.dotfiles"
alias kx="kubectx"
alias projects="cd ~/Documents/projects"
alias dn="dotnet"
alias dnrs="dotnet restore"
alias dnt="dotnet test"
alias dnwt="dotnet watch test"
alias dnwr="dotnet watch run"
alias dnb="dotnet build"
alias mdf="cd $MDF_CODE && code \`ls | fzf\`"
alias mdfc="cd $MDF_CODE && cursor \`ls | fzf\`"
alias mdfv="cd $MDF_CODE && cd \`ls | fzf\` && vim ."
alias mdfcd="cd $MDF_CODE && cd \`ls | fzf\`"
alias bxcd="cd ~/Documents/BornX/ && cd \`ls | fzf\`"
alias gmucd="cd ~/Documents/GMU/code/ && cd \`ls | fzf\`"
alias mmll="cd ~/Documents/mdf/mdf-ml && code ."
alias cf="cd \`ls -d */ | fzf\`"
alias i3="cd ~/.config/i3/"
alias sv="source .venv/bin/activate"

# Functions
cp() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git pull && c .
  else
    echo "Not a git repository. Opening in Cursor without pulling."
    c .
  fi
}

# Loop a command and show the output in vim
loop() {
  echo ":cq to quit\n" >/tmp/log/output
  fc -ln -1 >/tmp/log/program
  while true; do
    cat /tmp/log/program >>/tmp/log/output
    $(cat /tmp/log/program) |& tee -a /tmp/log/output
    echo '\n' >>/tmp/log/output
    vim + /tmp/log/output || break
    rm -rf /tmp/log/output
  done
}

# Source custom zsh files if they exist
if [ -d "$HOME/.zsh" ]; then
  for file in "$HOME/.zsh"/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
  unset file
fi

# Change to home directory at the end
cd ~
