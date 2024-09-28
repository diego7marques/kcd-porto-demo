#!/bin/bash
cloud=$1

echo "Installing FluxCD"

if [ $cloud == "aws" ]; then
    flux bootstrap github \
        --token-auth \
        --owner=diego7marques \
        --repository=kcd-porto-demo \
        --branch=main \
        --path=gitops/cluster-config/aws \
        --personal
elif [ $cloud == "azure" ]; then
    flux bootstrap github \
        --token-auth \
        --owner=diego7marques \
        --repository=kcd-porto-demo \
        --branch=main \
        --path=gitops/cluster-config/azure \
        --personal 
else 
    echo "Invalid cloud provider. Please provide 'aws' or 'azure'."
fi

sleep 10

kubectl create secret generic external-dns --namespace k8gb --from-file credentials