#!/bin/bash

set -e

source .env

# Create a new secret
echo $GITHUB_USERNAME

minikube kubectl -- create secret generic -n argocd gh-registry \
  --from-literal=enableOCI=true \
  --from-literal=type=helm \
  --from-literal=name=ghcr \
  --from-literal="url=ghcr.io/$GITHUB_REPOSITORY/charts" \
  --from-literal="username=$GITHUB_USERNAME" \
  --from-literal="password=$GITHUB_TOKEN"

minikube kubectl -- label secret -n argocd gh-registry argocd.argoproj.io/secret-type=repository

minikube kubectl -- create secret generic -n argocd gh-repo \
  --from-literal=url=https://github.com/$GITHUB_REPOSITORY.git \
  --from-literal="username=$GITHUB_USERNAME" \
  --from-literal="password=$GITHUB_TOKEN"

minikube kubectl -- label secret -n argocd gh-repo argocd.argoproj.io/secret-type=repository

minikube kubectl -- create secret docker-registry regcred -n api \
  --docker-server=https://ghcr.io \
  --docker-username=$GITHUB_USERNAME \
  --docker-password=$GITHUB_TOKEN
