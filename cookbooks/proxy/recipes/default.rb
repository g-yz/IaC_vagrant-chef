package 'nginx' do
    action :install
end

service 'nginx' do
    action [:enable, :start]
end

case node['platform_family']
when 'debian', 'ubuntu'
    execute "update" do
        command "apt update -y && apt upgrade -y"
        action :run
    end

    include_recipe 'proxy::ubuntu'
when 'rhel', 'fedora'
    execute "update" do
        command "sudo dnf update -y && sudo dnf upgrade -y"
        action :run
    end

    include_recipe 'proxy::centos'
end