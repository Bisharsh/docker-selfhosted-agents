#!/bin/bash
set -euox pipefail
add-apt-repository -y ppa:deadsnakes/ppa
declare -a pck=("python3.11" 
                "python3.11-venv"
                "openjdk-11-jdk"
                "unzip"
                )



for i in "${pck[@]}"
do
   echo "$i"
   apt-get update &&
   apt-get install -y --no-install-recommends "$i"
   echo "Install packages"
   rm -rf /var/lib/apt/lists/*
done

## Variable list for various downloadables ##
HELM="https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"

echo "Helm"
curl -fsSL -o get_helm.sh  $HELM && chmod 700 get_helm.sh && ./get_helm.sh -v v3.11.2 && ln -s /usr/local/bin/helm /usr/local/bin/helm3


