#ansible-playbook --ask-vault-pass -vvvv ./playbooks/test.yaml 
ansible-playbook -i ./hosts --vault-password-file ~/ansible_password -vvvv ./playbooks/test.yaml $1
