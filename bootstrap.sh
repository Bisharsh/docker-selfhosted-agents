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


## Python3.11
echo "python3.11"
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py 
## Add require module
pip install urllib3 yq==2.13.0

curl -L https://aka.ms/downloadazcopy-v10-linux -o azcopy.tar.gz
tar -xvf ./azcopy.tar.gz
cp azcopy*/azcopy /usr/bin

curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc