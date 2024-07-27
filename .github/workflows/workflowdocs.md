# Environment Variables:

This is the documented secret list for local reference

## Terraform Pre Apply:
```TF_CLOUD_ORGANIZATION: "raven-for-aws"``` \
```TF_API_TOKEN: "${{ secrets.TF_API_TOKEN }}"``` \
```TF_WORKSPACE: "Pre-Build_ECS-Lambda-Converter-App"``` \
```CONFIG_DIRECTORY: "./tf/pre/"```

## ECS Docker Image Build and Push:
```AWS_ROLE: "${{ secrets.AWS_ROLE }}"``` \
```ECR_ECS_REPO_1: "${{ secrets.ECR_ECS_REPO_1 }}"``` \
```ECR_LAM_REPO_1: "${{ secrets.ECR_LAM_REPO_1 }}"``` \
```AWS_REGION: us-east-1```

## Primary Terraform Plan/Apply:
```TF_CLOUD_ORGANIZATION: "raven-for-aws"``` \
```TF_API_TOKEN: "${{ secrets.TF_API_TOKEN }}"``` \
```TF_WORKSPACE: "ECS-Lambda-Converter-App"``` \
```CONFIG_DIRECTORY: "./tf/"```