# fluffy-carnival

## Journal

### 6:40pm

Initial read through of the task, is mostly clear. The uncertain parts are mainly around how I would like to implement this to make it as simple as possible for the user to reproduce it. The questions that come to mind:

- What should the repository look like? Is remote allowed? If not, what does creating CI/CD locally look like?
- Config-as-Code? I think it makes sense, reminds me of examples like policy as code in OPA.
- Python implementation is a little intimidating, due to the lack of pythons lib ecosystem but seems simple enough to overcome and nothing some docs on google cant fix.

### 6:50pm

Got some ideas of where to start with an image of what the overall product should look like. Reading the task again looking for answers/directions for the uncertain parts to help modify my idea. Mostly answered my questions by reading the example code, which helped quite a bit still uncertain on the implementation but I wont know that until I start hacking at it.

So overall design so far:

- Since of the top of my head I can't think of a "nice" way to implement a repo with ci/cd locally without mounting volumes and trying to point to it and also I noticed I am allowed to link to my repo when submitting my finished product. I am assuming a remote repo will be suffice. Github.. ticks lots of boxes:
- Github Actions for CI
- ghcr.io for container/helm registry
- has a remote endpoint I can point CD to watch for changes.
- ArgoCD for watching any changes happening on the repo this ticks the gitops approach, super familiar with it and easy to setup.
- Infrastructure of k8s is left ill be assuming docker is installed on the users computer and get them to install kind or even minikube. depends how easy exposing the services are, been a little while since doing it with both

### 7:01pm

I want to setup all infrastructure and linking of things first, create repo and gh user setup all that stuff.

### 7:15pm

Applied Journal notes into new gh repo, start investigating and building out folder structure. Mess around with the scripting to create the k8s clusters.

### 7:19pm

Going to use kustomization to apply the resources to support this setup. Just easy that way.

Will be just going with a mono repo for this, i am 95% confident argocd and gh actions can handle this behaviour to watch in directories. In an actual implementation i would rather have these seperate repos.

### 7:52pm
  
Added ci steps to gh actions to build the helm chart and docker image, However i am uncertain of the behaviour of the versioning, might be a little trial and error but since helm only supports semantic versioning with its packaging with OCI registries we must do 0.0.0-main. Might change to point to the repository directly in argocd app if its a pain and causes any problems. Going to test and see what i need to tweak, then move on to the boostrapping of the local k8s cluster.

Couple things I will need to setup for k8s to work properly..

- Generate a token in gh for registry and repository access.
- Will need 3 secrets, one for the image pulling and the 2 others for argocd to helm and repo changes.
- Also might look at terraform to bootstrap the db and tables in postgres.

### 8:08pm

Tested the ci steps to build and push to the repo had a few issues I thought were due to the pathing that ghcr allows but it ended up being a tick box in the UI to allow read and write perms for gh actions. Both helm and api look to be in the ghcr. Next will look at setting up the local k8s cluster.

### 8:44pm

Looked at the whole setup of minikube and installed and tested on my local machine, installed argocd into it. Decided to generate argocd resources with kustomization locally and stored them in the argocd folder to commit, this decision means reducing the need for the end user to install helm and kubectl on their machine.

### 9:10pm

Setup basic secrets for argocd to access gh and for k8s to pull from ghcr.

### 8:40am

Decided to go down the path of using a make file to help manage the commands, this allows us to configure a top level .env file with the secrets and any other variables we need which can filter throughout the bootstrapping to configure certain things. Trying to make things repo agnostic so forks just work to help reproduce the project, but we will see if i run into any roadblocks here.

- uncertain how I am going to approach one of the behaviours to implement: changes to the db IaC in main restart the database deployment. Don't exactly know the best approach for this since our database has no public access or tunnels currently, so gh actions cannot communicate with the db to either run tf against it or anything else. In a realworld scenario this isn't usually an issue. I don't think its nessissary to go down the path of creating a tunnel for this project. Could also look at argo events to watch the main branch and trigger a rollout restart of the db pod. (which is funny to me to restart the db 😅 on every IaC change)
- looking at how to apply the yaml mapping of endpoint to query, I've decided to go down the path of storing it in a configmap inside its helm chart. I don't necessarily like this approach, I feel there could be a more elegent way to do things but its not standing out to me at this moment.

### 8:58am

Just realised I don't need any secrets... since that all this is in a public repo. I look to have it etched in my head that everything needs access to the repos.

## Installation

### Prerequisites

There are some prerequisites to have already installed and configured to run this project.

#### Docker

We will be running this project in containers. [Docker Desktop](https://docs.docker.com/desktop/) is this easiest way to get started. Follow the installation guide for one of your platforms

- MacOS [https://docs.docker.com/desktop/setup/install/mac-install/]
- Windows [https://docs.docker.com/desktop/setup/install/windows-install/]
- Linux [https://docs.docker.com/desktop/setup/install/linux/]

Once installed check the docker daemon is running

```sh
docker info
```

#### Minikube

Minikube is the kubernetes cluster which will run all the nessissary infrastructure to support the API.

Install it by going to this site and choosing your choice of installation and platform relevent to your machine.

[https://minikube.sigs.k8s.io/docs/start]

Once installed run the following commands to start it

```sh
# Run this command to start the k8s cluster it will download and start it as a container in dockerhub.
minikube start

```

### Setup

```sh
```
