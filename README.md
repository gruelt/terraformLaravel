# terraformLaravel

Have your .aws credentials ready !

#Deploy infra
terraform init
terraform plan
terraform apply

#deploy conf on every host
ansible-playbook -i ansible/inventory ansible/playbook.yml

#### Populate your vars

- Have a Route53 ZoneId.
- Have a ssh key.
- Name your tags ( every instance linked will have this tag )
