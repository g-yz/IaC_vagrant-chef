template '/etc/nginx/nginx.conf' do
    source 'ubuntu.conf.erb'
    action :create
    notifies :restart, 'service[nginx]', :immediately
end
