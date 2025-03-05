control 'active-services' do
  title 'Ensure required services are running and enabled'
  desc 'This control checks that important services are enabled and running on the system.'

  if os.family == 'debian'
    describe service('nginx') do
      it { should be_enabled }
      it { should be_running }
    end
  elsif os.family == 'redhat'
    describe systemd_service('nginx') do
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe 'Unsupported OS Family' do
      it { should eq 'Unsupported' }
    end
  end
end
