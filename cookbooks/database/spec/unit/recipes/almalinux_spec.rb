require 'spec_helper'

describe 'database::default' do
    let(:platform) { 'almalinux' }
    let(:version)  { '8' }
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: platform, version: version).converge(described_recipe) }

    context 'on Almalinux' do
        before do
            stub_command('mysql -e "SHOW DATABASES;" | grep wordpress').and_return(false)
            stub_command("mysql -e \"SELECT User, Host FROM mysql.user WHERE User = 'wordpress' AND Host = '127.0.0.1'\" | grep wordpress").and_return(false)
            stub_command('systemctl is-active --quiet firewalld').and_return(false)
        end

        describe 'Update OS' do
            it { is_expected.to run_execute('update') }
        end

        describe 'Open port 3306 and reload firewall' do
            it { is_expected.to run_execute('firewall-cmd --zone=public --add-port=3306/tcp --permanent') }
            it { is_expected.to run_execute('firewall-cmd --reload') }
        end

        it 'installs mysql-server' do
            expect(chef_run).to install_package('mysql-server')
        end

        it 'enables and starts the mysqld service' do
            expect(chef_run).to enable_service('mysqld')
            expect(chef_run).to start_service('mysqld')
        end

        describe 'creates the wordpress database' do
            it { is_expected.to run_execute('create_mysql_database') }
        end

        describe 'creates the mysql user and grants privileges' do
            it { is_expected.to run_execute('create_mysql_user') }
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

