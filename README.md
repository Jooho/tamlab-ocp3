# Deploy OpenShift 3.11 on OpenStack

This doc explains how to deploy openshift 3.11 on OpenStack

In order to use this script, you need to know [OpenShift Service Account](https://access.redhat.com/terms-based-registry) so please prepare it at first.

If you know sa_name, you can get the information using the following URL
```
https://access.redhat.com/terms-based-registry/#/token/${sa_name}
```


## Steps

### Pre-requisites

- Install openstackclient(Fedora 28)
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install python-openstackclient
```

- Clone git repository
```
git clone https://github.com/Jooho/tamlab-ocp3.git
cd tamlab-ocp3
```

### Update openshift.yaml
You will put confidential information here so ansible-vault will be used. 
In this demo, I will use "redhat" for vault password but you must create ansible-password file under $HOME folder

- Create vault password
```
cat redhat > ~/ansible-password
```

- Update 'CHANGE_ME' part.
```
vi openshift.yaml

subs_id: 'CHANGE_ME'
subs_pw: 'CHANGE_ME'
...
oreg_auth_user_name: "CHANGE_ME"
oreg_auth_token: 'CHANGE_ME'
```
**NOTE** The subscription have to have a right permission to attach OpenShift repositories.
This script try to attach this subscription *Red Hat OpenShift Container Platform for Certified Cloud and Service Providers*. If you have a different one, you have to modify this.


- Encrypt the file
```
ansible-vault encrypt openshift.yaml
Vault password: redhat
```


### Update openstack.yaml
Like openshift.yaml file, this file also will be encrypted using ansible-vault

- Update 'CHANGE_ME'
```
vi openstack.yaml

auth_url: CHANGE_ME

# openstack cluster admin password
admin_user_pw: CHANGE_ME

# If you are using this script for your own openstack, please set this no
tamlab_dns_update: no

# If your own openstack use HTTPS, please update certificate information. If it uses HTTPS, please remove the line
  cacert: "CHANGE_ME"

```

- Encrypt the file
```
ansible-vault encrypt openstack.yaml
Vault password: redhat
```


### Update vars/all
This file contains most of the detail information for OpenShift and Openstack but you don't need to change much here.

- Update user information
```
vi vars/all

user_name: CHANGE_ME
user_pw: CHANGE_ME
user_email: CHANGE_ME

# external access domain name(eg. tamlab.brq.redhat.com)
external_dns_domain: CHANGE_ME
# Upstream dns server IP that can resolve external dns domain 
ocp_dns_forwarder: CHANGE_ME

```

### Install
If you follow the above instruction, now you can deploy OCP 3.11 on openstack.
```
./install.sh
```


### Uninstall
```
./uninstall.sh
```


## OCP Information

| name            | value                                                      |
| --------------- | ---------------------------------------------------------- |
| web console     | https://ocp-console.{USER_NAME}.{CLUSTER_NAME}.{external_dns_domain}:8443 |
| default user    | joe, sue, test[1..10]                                                 |
| default user pw | redhat|


