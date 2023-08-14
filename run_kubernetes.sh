#!/usr/bin/env bash

## Complete the following steps to get kubernetes pods running locally

# This is your Docker ID/path
dockerpath=amalsz/capstone-project

# Run the Docker Hub container with kubernetes
kubectl run amalsz/capstone-project\
    --generator=run-pod/v1\
    --image=$dockerpath\
    --port=80 --labels amalsz/capstone-project

# List kubernetes pods
kubectl get pod

# Forward the container port to a host
kubectl port-forward amalsz/capstone-project 8000:80
