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
  