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
sudo bash ./UnitTest/tests.sh
```

### Executing integration tests

kitchen test -p ubuntu-20.04
