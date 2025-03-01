template '/etc/nginx/nginx.conf' do
    source 'centos.conf.erb'
    action :create
    notifies :restart, 'service[nginx]', :immediately
end

selinux_boolean 'httpd_can_network_connect' do
    value true
    action :set
end

# Ensure firewalld is started before running the commands
execute 'start-firewalld' do
    command 'systemctl start firewalld'
    not_if 'systemctl is-active --quiet firewalld'
end

execute 'firewall-cmd --zone=public --add-port=80/tcp --permanent' do
    action :run
end

execute 'firewall-cmd --reload' do
    action :run
end
