[builder]
${builder_ip} ansible_user=ubuntu ansible_ssh_private_key_file=my_key.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'

[web]
${web_ip} ansible_user=ubuntu ansible_ssh_private_key_file=my_key.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'