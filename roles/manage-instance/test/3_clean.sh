#ansible-playbook --ask-vault-pass -vvvv ./playbooks/clean.yaml
ansible-playbook --vault-password-file ~/ansible_password -vvvv ./playbooks/clean.yaml $1


