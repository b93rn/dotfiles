# kube-ps1 configuration
# This file contains all customizations for the Kubernetes prompt

# Enable the Kubernetes symbol
KUBE_PS1_SYMBOL_ENABLE=false

# Add padding after the symbol for better readability
KUBE_PS1_SYMBOL_PADDING=true

# Change prefix and suffix to match agnoster theme style with powerline segments
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=""

# Change separator and divider for agnoster theme style
KUBE_PS1_SEPARATOR=""
KUBE_PS1_DIVIDER=">"

# Set colors for different parts of the prompt
KUBE_PS1_SYMBOL_COLOR="cyan"
KUBE_PS1_CTX_COLOR="yellow"
KUBE_PS1_NS_COLOR="blue"
KUBE_PS1_PREFIX_COLOR="blue"
KUBE_PS1_SUFFIX_COLOR="blue"

# Custom function to format the cluster context (shortens long names)
function get_cluster_short() {
  # If context contains dots (like cluster.domain.com), show only first part
  if [[ "$1" == *"."* ]]; then
    echo "$1" | cut -d '.' -f1
  else
    echo "$1"
  fi
}
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

# Custom function to format namespace with emoji indicators for important namespaces
function get_namespace_with_icon() {
  local ns="$1"
  echo "$ns"
}
KUBE_PS1_NAMESPACE_FUNCTION=get_namespace_with_icon

# Function to toggle kube-ps1 display on/off
function kubeon() {
  PROMPT='$(kube_ps1)'$PROMPT
}

function kubeoff() {
  PROMPT=${PROMPT/\$\(kube_ps1\)/}
}

# Set up prompt with kube-ps1 if not already set
if [[ ! "$PROMPT" == *"kube_ps1"* ]]; then
  PROMPT='$(kube_ps1)'$PROMPT
fi 