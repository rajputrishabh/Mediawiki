This repository will help you setup Mediawiki on AWS EC2 instance in fully automated fashion using Terraforma, AWS cli and Ansible.

Terraform is responsible for provisioning infrastructure on AWS while Ansible helps setup Mediawiki.

**PreRequisites :

Please set up authentication between AWS and terraform via following methods in the documentation:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

It is expected to have id_rsa and id_rsa.pub file present in ~/.ssh folder.
If not, please follow below link to generate the key:

https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

**How to Execute Terrform Scripts - 

Terraform file -
Please refer to file - main.tf


1. Init -
terraform init

2. Plan -
terrform plan

3. Apply -
terraform apply

4. Destroy -
terraform destroy

Make sure you maintain file structure as in repository as is. There might be unforeseen errors if file/folder structure or name is changed.

Once terraform apply is run, make sure to check the progress in terminal. Terraform will invoke ansible playbooks for MediaWiki deployment.

Post completion of terraform apply, you will get public IP as output. Please copy it and open in browser.

URL will be http://<public-IP>/mediawiki
