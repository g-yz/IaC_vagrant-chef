# IaC using vagrant and chef

## Architecture



## Requirements

Requirements to execute this project
- VirtualBox 7.1
- Vagrant 2.4.3

Requirements to test project
- Ruby 3.2.3
- Test kitchen
- Chef

### Requirements for executing

Install Virtual Box
https://www.virtualbox.org/wiki/Downloads
```sh
sudo apt update
sudo apt install virtualbox
```

Install Vagrant
https://developer.hashicorp.com/vagrant/install
```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
```

### Requirements for testing

Install chef (It already contains _Chef_, _Test Kitchen_ and _Inspec_)
https://community.chef.io/downloads/tools/workstation?os=ubuntu


## Execution

### Executing project

Execute
```sh
vagrant up
```

Open
http://192.168.56.2/wp-admin

### Executing unit tests

```sh
bash ./scripts/start.sh
```

### Executing integration tests

kitchen test -p ubuntu-20.04

```sh
bash ./scripts/start.sh
```

# Current versions

✓ vagrant is installed. Version: Vagrant 2.4.3
✓ vboxmanage is installed. Version: 7.1.6r167084
✓ git is installed. Version: git version 2.43.0
✓ chef-client is installed. Version: Chef Infra Client: 15.0.300
✓ inspec is installed. Version: 4.3.2

Your version of InSpec is out of date! The latest version is 6.8.24.
✓ chefspec is installed in Chef Workstation. Version: 7.3.4
✓ rspec is installed in Chef Workstation. Version: 3.8.0
✓ kitchen is installed. Version: Test Kitchen version 2.2.5
