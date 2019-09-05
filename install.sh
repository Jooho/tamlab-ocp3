#ansible-playbook -i hosts --vault-password-file ~/ansible_password playbooks/full-flow.yaml -vvvv -e @./openstack.yaml -e @vars/all -e @openshift.yaml
echo "ansible-playbook -i hosts playbooks/full-flow.yaml -vvvv -e @./openstack.yaml -e @vars/all -e @openshift.yaml -e cmd=install $@"
ansible-playbook -i hosts playbooks/full-flow.yaml -vvvv -e @./openstack.yaml -e @vars/all -e @openshift.yaml -e cmd=install $@
