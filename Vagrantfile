DB_IP="192.168.56.20"
WP_IP="192.168.56.10"
PROXY_IP="192.168.56.2"
DB_USER='wordpress'
DB_PWD='admin123'

Vagrant.configure("2") do |config|
    # config.env.enable              # Enable vagrant-env(.env)

    if ENV['TESTS'] == 'true'
        config.vm.define "test" do |testing|
            testing.vm.box = ENV["BOX_NAME"] || "ubuntu/focal64"  # Use a default Ubuntu 20.04 image

            testing.vm.provision "shell", inline: <<-SHELL
                # Install ChefDK
                wget -qO- https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk

                export CHEF_LICENSE="accept"

                # Install the gems required for testing
                cd /vagrant/cookbooks/database && chef exec bundle install
                cd /vagrant/cookbooks/wordpress && chef exec bundle install
                cd /vagrant/cookbooks/proxy && chef exec bundle install

                chown -R vagrant:vagrant /opt/chefdk
            SHELL
        end
    else
        config.vm.define "database" do |db|
            db.vm.box = ENV["BOX_NAME"] || "ubuntu/focal64"  # Use a default Ubuntu 20.04 image
            db.vm.hostname = "db.vm.com"
            db.vm.network "private_network", ip: "192.168.56.20"

            db.vm.provision "chef_solo" do |chef|
                chef.install = "true"
                chef.arguments = "--chef-license accept"
                chef.add_recipe "database"
                chef.json = {
                    "config" => {
                        "db_ip" => "192.168.56.20",
                        "wp_ip" => "192.168.56.10",
                        "db_user" => "wordpress",
                        "db_pwd" => "admin123"
                    }
                }
            end
        end

        config.vm.define "wordpress" do |web|
            web.vm.box = ENV["BOX_NAME"] || "ubuntu/focal64"  # Use a default Ubuntu 20.04 image
            web.vm.hostname = "wordpress.vm.com"
            web.vm.network "private_network", ip: "192.168.56.10"

            web.vm.provision "chef_solo" do |chef|
                chef.install = "true"
                chef.arguments = "--chef-license accept"
                chef.add_recipe "wordpress"
                chef.json = {
                    "config" => {
                        "db_ip" => "192.168.56.20",
                        "db_user" => "wordpress",
                        "db_pwd" => "admin123"
                    }
                }
            end
        end

        config.vm.define "proxy" do |proxy|
            proxy.vm.box = ENV["BOX_NAME"] || "ubuntu/focal64"  # Use a default Ubuntu 20.04 image
            proxy.vm.hostname = "wordpress.vm.com"
            proxy.vm.network "private_network", ip: "192.168.56.2"

            proxy.vm.provision "chef_solo" do |chef|
                chef.install = "true"
                chef.arguments = "--chef-license accept"
                chef.add_recipe "proxy"
                chef.json = {
                    "config" => {
                        "wp_ip" => "192.168.56.10"
                    }
                }
            end
        end
    end
end