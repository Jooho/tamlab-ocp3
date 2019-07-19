Ansible Role: DNS Operation (add/remove address, add/remove nameserver)
=========

This role help operate DNS record

*Details*
- Install DNSmasq
- Copy forwarder.conf for upstream DNS
- Add/Remove address or nameserver

Requirements
------------
None

Role Variables
--------------

| Name                 | Default value  | Requird | Description                                                                  |
| -------------------- | -------------- | ------- | ---------------------------------------------------------------------------- |
| dns_conf_name        | undefined      | yes     | dnsmasq conf file (/etc/dnsmasq.d/file.conf)                                 |
| dns_conf_path        | /etc/dnsmasq.d | no      | dnsmasq conf path                                                            |
| rewrite_conf         | true           | no      | Set false if you don't want to overwrite conf file when it exists            |
| forward_dns          | 8.8.8.8        | no      | Set upstream DNS nameservers                                                 |
| rewrite_forward_conf | false          | no      | Set true if upstream DNS nameservers are changed                             |
| dns_ops              | install        | no      | Set install for dnsmasq package, add/remove for address or nameserver        |
| new_ip               | undefined      | yes     | For address record, it will map to new_hostname or new_nameserver_search_for |
| new_hostname         | undefined      | yes     | For address record, it will map to new_ip                                    |
| new_ns_search_for    | undefined      | yes     | For nameserver recode, it will map to new_ip                                 |

Dependencies
------------

None


Example Playbook - Install
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-dnsmasq-operate
      vars:
        dns_ops: add
~~~

Example Playbook - add/remove address
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-dnsmasq-operate
      vars:
        dns_conf_name: test
        dns_ops: add
        new_ip: 1.1.1.1
        new_hostname: test.example.com

or

- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-dnsmasq-operate
      vars:
        dns_conf_name: test
        dns_ops: remove
        new_ip: 1.1.1.1
        new_hostname: test.example.com
        forwarder_dns:
        - 1.1.1.2
        - 1.1.1.3
~~~



Example Playbook - add/remove nameserver
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-dnsmasq-operate
      vars:
        dns_conf_name: test
        dns_ops: add
        new_ip: 1.1.1.1
        new_ns_search_for: apps.example.com

or

- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-dnsmasq-operate
      vars:
        dns_conf_name: test
        dns_ops: remove
        new_ip: 1.1.1.1
        new_ns_search_for: apps.example.com
~~~



License
-------

BSD/MIT

Author Information
------------------

This role was created in 2018 by [Jooho Lee](http://github.com/jooho).
