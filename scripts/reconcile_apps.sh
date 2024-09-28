#! /bin/bash
KUBERNETES_MASTER=k8gb-kcdporto-azure flux reconcile kustomization apps -n flux-system --with-source &
KUBERNETES_MASTER=arn:aws:eks:us-east-1:024848453634:cluster/k8gb-kcdporto-aws flux reconcile kustomization apps -n flux-system --with-source &
wait