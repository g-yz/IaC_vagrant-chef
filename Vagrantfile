require './config.rb'

Vagrant.configure("2") do |config|
    config.vm.define "database" do |db|
        db.vm.box = $vm_so_box
        db.vm.hostname = "db.vm.com"
        db.vm.network "private_network", ip: vm_db_ip

        db.vm.provider "virtualbox" do |vb|
            vb.name = "vm_database"
        end

        db.vm.provision "chef_solo" do |chef|
            chef.install = "true"
            chef.arguments = "--chef-license accept"
            chef.add_recipe "database"
            chef.json = {
                "config" => {
                    "db_ip" => $vm_db_ip,
                    "wp_ip" => $vm_wp_ip,
                    "db_user" => $vm_db_user,
                    "db_pwd" => $vm_db_pwd
                }
            }
        end
    end

    config.vm.define "wordpress" do |web|
        web.vm.box = $vm_so_box
        web.vm.hostname = "wordpress.vm.com"
        web.vm.network "private_network", ip: $vm_wp_ip

        web.vm.provider "virtualbox" do |vb|
            vb.name = "vm_wordpress"
        end

        web.vm.provision "chef_solo" do |chef|
            chef.install = "true"
            chef.arguments = "--chef-license accept"
            chef.add_recipe "wordpress"
            chef.json = {
                "config" => {
                    "db_ip" => $vm_db_ip,
                    "db_user" => $vm_db_user,
                    "db_pwd" => $vm_db_pwd
                }
            }
        end
    end

    config.vm.define "proxy" do |proxy|
        proxy.vm.box = $vm_so_box
        proxy.vm.hostname = "wordpress.vm.com"
        proxy.vm.network "private_network", ip: $vm_proxy_ip

        proxy.vm.provider "virtualbox" do |vb|
            vb.name = "vm_proxy"
        end

        proxy.vm.provision "chef_solo" do |chef|
            chef.install = "true"
            chef.arguments = "--chef-license accept"
            chef.add_recipe "proxy"
            chef.json = {
                "config" => {
                    "wp_ip" => $vm_wp_ip
                }
            }
        end
    end
end
