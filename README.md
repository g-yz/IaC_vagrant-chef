# IaC using vagrant and chef

## Architecture



## Requirements

### Project Execution Requirements
- *VirtualBox*: 7.1
- *Vagrant*: 2.4.3

### Unit Testing Requirements
- *Chef*: 15.0.300
- *Chefspec*: 7.3.4
- *RSpec*: 3.8.0

### Integration Testing Requirements
- *Test Kitchen*: 2.2.5
- *Inspec*: 4.3.2

## Installing requirements

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

Install chef (It already contains _Chef_, _Test Kitchen_, _Inspec_ , _Rspec_ and _ChefSpec_)
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
