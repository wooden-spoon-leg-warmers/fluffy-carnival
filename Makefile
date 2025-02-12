include .env

create-secrets:
	# Create the secrets for the project
	.scripts/create-secrets.sh 

delete-secrets:
	minikube kubectl -- delete secret -n argocd gh-registry
	minikube kubectl -- delete secret -n argocd gh-repo
	minikube kubectl -- delete secret -n argocd regcred

bootstrap:
	# Bootstrap the project
	minikube start

argocd-serve:
	# Serve the argocd
	minikube kubectl -- port-forward svc/argocd-server -n argocd 8080:443

argocd-password:
	# Get the password for the argocd
	minikube kubectl -- get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d