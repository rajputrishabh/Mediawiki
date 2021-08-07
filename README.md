This repository will help you install Mediawiki on AWS in fully automated fashion using Terraforma, AWS cli and Ansible.

Terraform is responsible for provisioning infrastructure on AWS while Ansible helps install Mediawiki.

How to Execute Terrform Scripts - 

Terraform file -
Please refer to file - main.tf

Plan -
terrform plan

Apply -
terraform apply

Destroy -
terraform destroy

Make sure you maintain file structure as is in repository. Code will not work if file/folder structure or name is changed.

Once terraform apply is run, make sure to check the progress in terminal. Terraform will invoke ansible playbooks for MediaWiki deployment.

Post completion of terraform apply, you will get public IP as output. Please copy it and open in browser.

URL will be http://<public-IP>/mediawiki
