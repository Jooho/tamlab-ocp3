#ansible-playbook -i hosts playbooks/uninstall.yaml -vvvv --vault-password-file ~/ansible_password -e @vars/all -e cmd=uninstall 
ansible-playbook -i hosts playbooks/uninstall.yaml -vvvv --vault-password-file ~/ansible_password -e @./openstack.yaml -e @vars/all -e cmd=uninstall 

