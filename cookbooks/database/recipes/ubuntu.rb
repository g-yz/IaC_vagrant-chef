if node != nil && node['config'] != nil
    db_user = node['config']['db_user'] || "wordpress"
    db_pwd = node['config']['db_pwd'] || "wordpress"
    db_ip   = node['config']['db_ip'] || "127.0.0.1"
    wp_ip   = node['config']['wp_ip'] || "127.0.0.1"
else
    db_user = "wordpress"
    db_pwd = "wordpress"
    db_ip   = "127.0.0.1"
    wp_ip   = "127.0.0.1"
end

# Install MySQL server
apt_package 'mysql-server' do
    action :install
end

# Enable MySQL service
service 'mysql' do
    action [:enable, :start]
end

# Run command to create the database
execute 'create_mysql_database' do
    command 'mysql -e "CREATE DATABASE wordpress;"'
    action :run
    not_if 'mysql -e "SHOW DATABASES;" | grep wordpress'
end

# Run command to create user and grant permissions
execute 'create_mysql_user' do
    command "mysql -e \"CREATE USER '#{db_user}'@'#{wp_ip}' IDENTIFIED BY '#{db_pwd}'; GRANT ALL PRIVILEGES ON wordpress.* TO '#{db_user}'@'#{wp_ip}'; FLUSH PRIVILEGES;\""
    action :run
    not_if "mysql -e \"SELECT User, Host FROM mysql.user WHERE User = '#{db_user}' AND Host = '#{wp_ip}'\" | grep #{db_user}"
end

execute 'bind_service' do
    command "sed -i 's/127.0.0.1/#{db_ip}/g' /etc/mysql/mysql.conf.d/mysqld.cnf"
    action :run
    notifies :restart, 'service[mysql]', :immediately
    only_if { ::File.exist?('/etc/mysql/mysql.conf.d/mysqld.cnf') }
end
