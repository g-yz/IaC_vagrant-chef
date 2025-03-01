if node != nil && node['config'] != nil
    db_ip = node['config']['db_ip'] || "127.0.0.1"
else
    db_ip = "127.0.0.1"
end

execute "add host" do
    command "echo '#{db_ip}       db.vm.com' >> /etc/hosts"
    action :run
end

case node['platform_family']
when 'debian', 'ubuntu'
    execute "update" do
        command "apt update -y && apt upgrade -y"
        action :run
    end
    include_recipe 'wordpress::ubuntu_web'    # Install web server
    include_recipe 'wordpress::ubuntu_wp'     # Install wordpress
when 'rhel', 'fedora'
    execute "update" do
        command "sudo dnf update -y && sudo dnf upgrade -y"
        action :run
    end
    include_recipe 'wordpress::almalinux_web'    # Install web server
    include_recipe 'wordpress::almalinux_wp'     # Install wordpress
end

if node != nil && node['config'] != nil
    include_recipe 'wordpress::post_install'
end