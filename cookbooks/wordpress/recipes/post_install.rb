# Install WP CLI
remote_file '/tmp/wp' do
  source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Mover WP CLI a /bin
execute 'Move WP CLI' do
  command 'mv /tmp/wp /bin/wp'
  not_if { ::File.exist?('/bin/wp') }
end

# Make WP CLI executable
file '/bin/wp' do
  mode '0755'
end

# Install Wordpress and configure
execute 'Finish Wordpress installation' do
  command 'sudo -u vagrant -i -- wp core install --path=/opt/wordpress/ --url=192.168.56.2 --locale=es_ES --title="DevOps - Deployment Automation Tools" --admin_user=admin --admin_password="admin123" --admin_email=admin@example.com'
  not_if 'wp core is-installed', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end

# Install and activate a WordPress theme (e.g., Astra)
execute 'Install WordPress theme' do
  command 'sudo -u vagrant -i -- wp theme install colormag --activate --path=/opt/wordpress/'
  not_if 'wp theme is-active astra', environment: { 'PATH' => '/bin:/usr/bin:/usr/local/bin' }
end
