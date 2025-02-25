function k --wraps='kubectl --kubeconfig $(pwd)/dev/devops/kube.ah2.config' --description 'alias k=kubectl --kubeconfig $(pwd)/dev/devops/kube.ah2.config'
  kubectl --kubeconfig ~/dev/devops/kube.ah2.config $argv; 
end
