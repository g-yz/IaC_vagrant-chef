require 'spec_helper'

describe 'wordpress::default' do
    let(:platform) { 'almalinux' }
    let(:version)  { '8' }
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: platform, version: version).converge(described_recipe) }

    context 'on Almalinux' do
        before do
            stub_command('::File.exist?("/tmp/wordpress.zip")').and_return(false)
            stub_command('::File.exist?("/opt/wordpress")').and_return(false)
            stub_command('::File.exist?("/opt/wordpress/wp-config.php")').and_return(false)
            stub_command('::File.exist?("/etc/httpd/conf.d/wordpress.conf")').and_return(false)
            stub_command('systemctl is-active --quiet firewalld').and_return(false)
            stub_command('dnf list installed remi-release').and_return(true)
        end

        it 'installs httpd package' do
            expect(chef_run).to install_package('httpd')
        end

        it 'installs php package' do
            expect(chef_run).to install_package('php')
        end

        it 'installs php-mysqlnd package' do
            expect(chef_run).to install_package('php-mysqlnd')
        end

        it 'installs php-json package' do
            expect(chef_run).to install_package('php-json')
        end

        it 'installs unzip package' do
            expect(chef_run).to install_package('unzip')
        end

        it 'installs curl package' do
            expect(chef_run).to install_package('curl')
        end

        it 'creates the info.php file' do
            expect(chef_run).to create_file('/var/www/html/info.php').with_content("<?php\nphpinfo();\n?>")
        end

        it 'opens port 8080 in the firewall' do
            expect(chef_run).to run_execute('firewall-cmd --zone=public --add-port=8080/tcp --permanent')
        end

        it 'opens port 80 in the firewall' do
            expect(chef_run).to run_execute('firewall-cmd --zone=public --add-port=80/tcp --permanent')
        end

        it 'reloads the firewall' do
            expect(chef_run).to run_execute('firewall-cmd --reload')
        end

        it 'enables and starts the httpd service' do
            expect(chef_run).to enable_service('httpd')
            expect(chef_run).to start_service('httpd')
        end

        # Test wordpress installation
        describe 'Install wordpress' do
            it { is_expected.to run_execute('get wordpress') }
            it { is_expected.to run_execute('extract_wordpress') }
            it { is_expected.to create_template('/opt/wordpress/wp-config.php') }
            it { is_expected.to create_template('/etc/httpd/conf.d/wordpress.conf') }
        end

        after(:each) do |example|
            if example.exception.nil?
                puts "  ✓ :                                            #{platform} #{version}"
            else
                puts "  ✗ :                                            #{platform} #{version}"
            end
        end
    end
end
