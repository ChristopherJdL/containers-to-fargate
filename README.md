# Containers to Fargate

> [!NOTE]
><p>
>  <img src="https://github.gallerycdn.vsassets.io/extensions/github/vscode-github-actions/0.31.0/1769723054158/Microsoft.VisualStudio.Services.Icons.Default" alt="GitHub Actions icon" width="48"
>       style="vertical-align: middle; margin-right: 8px;">
>  <span><strong>Uses GitHub Actions.</strong></span>
> </p>


Project that deploys containers to AWS Fargate.


# Choices
- I have chosen to:
    - Deploy the container to [Docker Hub](https://hub.docker.com/repository/docker/christopherjdl/containers-to-fargate/general), instead of ECR, but for production use cases I would deploy it on a private image registry like ECR, of course.
    - 