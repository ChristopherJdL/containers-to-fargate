# Containers to Fargate

> [!NOTE]
><p>
>  <img src="https://github.gallerycdn.vsassets.io/extensions/github/vscode-github-actions/0.31.0/1769723054158/Microsoft.VisualStudio.Services.Icons.Default" alt="GitHub Actions icon" width="48"
>       style="vertical-align: middle; margin-right: 8px;">
>  <span><strong>Uses GitHub Actions.</strong></span>
> </p>


Project that deploys containers to AWS Fargate.


# Choices
I have chosen to deploy the container image to [Docker Hub](https://hub.docker.com/repository/docker/christopherjdl/containers-to-fargate/general) for my own convenience, instead of ECR. Although, for production use cases I would deploy it on a private image registry like ECR, of course.

## Notes about the sandbox and Terraform state

This solution was developed and exercised in the AWS sandbox provided for the assignment.

- The AWS account in eu-north-1 operates with a modest VPC quota, which can be approached after multiple end‑to‑end test runs of the pipeline.
- When this quota is approached or reached, subsequent Terraform applies. That would create an additional VPC. A creation that can report a `VpcLimitExceeded` message.
- For this exercise, the Terraform state is stored locally, as the sandbox account does not expose the possibility to create an S3 bucket or similar remote backend for state storage.

In a typical production setting, this would normally be handled by configuring a remote backend or state (for example S3 on AWS) to preserve state across runs.

The pipeline has been [run successfully ✅ in this sandbox](https://github.com/ChristopherJdL/containers-to-fargate/actions/runs/22071483212); any later quota‑related messages are linked to the characteristics of the shared environment rather than to the core Terraform design.
