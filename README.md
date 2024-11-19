# Terraform

![image](https://github.com/user-attachments/assets/8df84c79-0734-48a9-a649-48f9d4f2889d)

![Uploading image.png…]()


**How to write a code?**

When you begin writing Terraform code, it’s essential to follow consistent standards for all resources. This ensures maintainability, readability, and easier collaboration across the team.


```bash
resource aws_vpc "app_zone_vpc" {
    # 
}
```

**How do I test the Terraform code locally?**

To export AWS credentials, you can use the following commands in your terminal:

```bash
export AWS_ACCESS_KEY_ID="ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="SECRET_KEY"
export AWS_REGION="REGION"
```

Replace `ACCESS_KEY`, `SECRET_KEY`, and `REGION` with your actual AWS credentials and region. This will set the environment variables for your current terminal session.

```cmd
terraform init
terraform plan -var-file=terraform-dev.tfvars
terraform apply -auto-approve -var-file=terraform-dev.tfvars
```

* If we want to destroy use this command (Do not use dev environment)

```cmd
terraform destroy -auto-approve -var-file=terraform-dev.tfvars
```

* This sequence of commands will initialize Terraform, generate a plan with the specified variables file `terraform-dev.tfvars`, and apply the configuration to provision the resources without needing manual approval.
