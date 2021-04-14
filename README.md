# terraformLaravel

Have your .aws credentials ready !

#Deploy infra
terraform init
terraform plan
terraform apply

#deploy conf on every host
ansible-playbook -i ansible/inventory ansible/playbook.yml
