#ansible-playbook -i hosts --vault-password-file ~/ansible_password playbooks/full-flow.yaml -vvvv -e @./openstack.yaml -e @vars/all -e @openshift.yaml
ansible-playbook -i hosts --vault-password-file ~/ansible_password playbooks/full-flow.yaml -vvvv -e @./openstack.yaml -e @vars/all -e @openshift.yaml -e ignore_validate=true 
