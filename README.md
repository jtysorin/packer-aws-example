# Packer AWS Image Builder

This project demonstrates how to use Packer to build an Amazon Machine Image (AMI) in AWS. The process is automated through GitHub Actions workflows.

## Packer Example

### Prerequisites
- AWS account
- Packer installed locally or configured in CI/CD environment

### Usage

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/your-packer-project.git
   cd your-packer-project
   ```

2. Set your AWS credentials as GitHub Secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

3. Run Packer locally:

    ```
    packer init .
    packer validate .
    packer build .
    ```
    
# GitHub Actions Workflows

## Workflow 1: Using hashicorp/setup-packer@main

This workflow is triggered manually or on a workflow dispatch event. It sets up Packer using the `hashicorp/setup-packer` action and runs the build process.

## Workflow 2: Using hashicorp/packer:latest Docker container

This workflow is triggered on pushes to the master branch or manually. It runs Packer using the `hashicorp/packer:latest` Docker container.