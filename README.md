# cloudbuild-example
Example project to showcase cloud build

## Submit Cloud Build Job
### Build the `test` stage only for automated testing
```
gcloud builds submit --config=cloudbuild-test.yaml
```

### Build the `prod` version
```
gcloud builds submit \
    --config=cloudbuild-deploy.yaml \
    --substitutions=_REPO_NAME=helloapp,_COMMIT_SHA=$(git rev-parse --short HEAD)
```

### Build the `test` stage using Kaniko
```
gcloud builds submit \
    --config=cloudbuild-kaniko-test.yaml \
    --substitutions=_REPO_NAME=helloapp
```

### Build the `prod` stage using Kaniko
```
gcloud builds submit \
    --config=cloudbuild-kaniko-deploy.yaml \
    --substitutions=_REPO_NAME=helloapp,_COMMIT_SHA=$(git rev-parse --short HEAD)
```