# ERPNext deploy with Docker-Compose and Ansible

Deploy part of the university project (Zastosowania Informatyki 2).

## Prerequisites

Ansible and roles/collections:

- [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
- [geerlingguy.pip](https://github.com/geerlingguy/ansible-role-pip)
- [community.docker](https://github.com/ansible-collections/community.docker)

You can install all required roles and collections with:

```bash
ansible-galaxy install geerlingguy.docker geerlingguy.pip community.docker
```

Run `ssh-agent` if you connect with keys via SSH:

```bash
eval $(ssh-agent)
ssh-add ~/.ssh/zi
```

Otherwise (if you connect with the password) make sure that package `sshpass` is installed on your computer.

Adjust properites in `hosts.yaml` and `frappe-docker/env-*`.

## Deploy with playbooks

Setup stuff on machine (install Docker, Docker Compose):

```bash
ansible-playbook setup.yaml -i hosts.yaml -l srv_test -K
```

Deploy ERPNext:

```bash
ansible-playbook deploy-erp.yaml -i hosts.yaml -l srv_test -K
```

Undeploy ERPNext:

```bash
ansible-playbook undeploy-erp.yaml -i hosts.yaml -l srv_test -K
```
