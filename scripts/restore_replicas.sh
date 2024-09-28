#! /bin/sh
flux resume kustomization -n flux-system apps  
kubectl scale deploy hello-kubernetes-hello-kubernetes --replicas=2 -n hello-kubernetes