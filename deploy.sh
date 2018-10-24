#!/bin/bash

# Exit on any error
set -e

./k8s/dynamic_config.sh

echo `cat ./k8s/k8s.config.yml`
kubectl apply -f ./k8s/k8s.config.yml
