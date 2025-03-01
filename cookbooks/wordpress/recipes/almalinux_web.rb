# Install Remi repository for AlmaLinux (or CentOS)
execute 'install_remi_repo' do
    command 'dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm'
    action :run
    not_if 'dnf list installed remi-release'
end

# Reset PHP module and enable the desired PHP version (7.4 or 8.0)
execute 'enable_php_7_4' do
    command 'dnf module reset php -y && dnf module enable php:remi-7.4 -y'
    action :run
end  

package "httpd" do
    action :install
end

package "php" do
    action :install
end

package "php-mysqlnd" do
    action :install
end

package "php-json" do
  action :install
end

package "unzip" do
    action :install
end

package "curl" do
    action :install
end

file "/var/www/html/info.php" do
    content "<?php\nphpinfo();\n?>" 
end

selinux_boolean 'httpd_can_network_connect' do
    value true
    action :set
end

selinux_boolean 'httpd_can_network_connect_db' do
    value true
    action :set
end

# Ensure firewalld is started before running the commands
execute 'start-firewalld' do
    command 'systemctl start firewalld'
    not_if 'systemctl is-active --quiet firewalld'
end

execute 'firewall-cmd --zone=public --add-port=8080/tcp --permanent' do
    action :run
end

execute 'firewall-cmd --zone=public --add-port=80/tcp --permanent' do
    action :run
end

execute 'firewall-cmd --reload' do
    action :run
end

service "httpd" do
    action [:enable, :start]
end