require 'spec_helper'

describe 'proxy::default' do
    let(:platform) { 'almalinux' }
    let(:version)  { '8' }
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: platform, version: version).converge(described_recipe) }

    context 'on Almalinux' do
        before do
            stub_command('systemctl is-active --quiet firewalld').and_return(false)
        end

        describe 'Update OS' do
            it { is_expected.to run_execute('update') }
        end

        describe 'Install and configure Nginx' do
            it { is_expected.to install_package('nginx') }
            it { is_expected.to create_template('/etc/nginx/nginx.conf') }
            it { is_expected.to start_service('nginx') }
            it { is_expected.to run_execute('firewall-cmd --zone=public --add-port=80/tcp --permanent') }
            it { is_expected.to run_execute('firewall-cmd --reload') }
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
