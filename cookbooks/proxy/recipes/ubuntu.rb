package 'nginx' do
    action :install
end

service 'nginx' do
    action [:enable, :start]
end

template '/etc/nginx/nginx.conf' do
    source 'ubuntu.conf.erb'
    action :create
    notifies :restart, 'service[nginx]', :immediately
end
