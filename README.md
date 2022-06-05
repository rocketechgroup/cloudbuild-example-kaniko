# cloudbuild-example
Example project to showcase cloud build

## Submit Cloud Build Job
### Build the `test` stage only for automated testing
```
gcloud builds submit --config=1.cloudbuild-test.yaml
```

### Build the `prod` version
```
gcloud builds submit \
    --config=2.cloudbuild-deploy.yaml \
    --substitutions=_REPO_NAME=helloapp,_COMMIT_SHA=$(git rev-parse --short HEAD)
```

### Build the `test` stage using Kaniko
```
gcloud builds submit \
    --config=3.cloudbuild-kaniko-test.yaml \
    --substitutions=_REPO_NAME=helloapp
```

### Build the `prod` stage using Kaniko
```
gcloud builds submit \
    --config=4.cloudbuild-kaniko-deploy.yaml \
    --substitutions=_REPO_NAME=helloapp,_COMMIT_SHA=$(git rev-parse --short HEAD)
```