#! /bin/sh
flux suspend kustomization -n flux-system apps  
kubectl scale deploy hello-kubernetes-hello-kubernetes --replicas=0 -n hello-kubernetes