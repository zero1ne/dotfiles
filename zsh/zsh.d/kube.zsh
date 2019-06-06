
alias kube=kubectl
alias k=kubectl

alias kgd="kubectl get deployments"
alias kgp="kubectl get pod"
alias kgs="kubectl get svc -o wide"
alias kgn="kubectl get node"
alias kconn="kubectl get node"

kprofile() {
  if [[ -z $1 ]]; then
    echo "usage: kprofile [profile]"
  else
    kubedir="$HOME/.kube"
    rm -f $kubedir/config
    ln -s $kubedir/$1 $kubedir/config
  fi
}
