# cloudbuild-example
Example project to showcase cloud build

## Submit Cloud Build Job
### Build the `test` stage using Kaniko
```
gcloud builds submit \
    --config=1.cloudbuild-kaniko-test.yaml \
    --substitutions=_REPO_NAME=helloapp
```

### Build the `prod` stage using Kaniko
```
gcloud builds submit \
    --config=2.cloudbuild-kaniko-deploy.yaml \
    --substitutions=_REPO_NAME=helloapp,_COMMIT_SHA=$(git rev-parse --short HEAD),_TS=$(date +%s)
```