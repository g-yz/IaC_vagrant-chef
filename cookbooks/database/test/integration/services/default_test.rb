control 'active-services' do
  title 'Ensure required services are running and enabled'
  desc 'This control checks that important services are enabled and running on the system.'

  if os.family == 'debian'
    describe service('mysql') do
      it { should be_enabled }
      it { should be_running }
    end
  elsif os.family == 'redhat'
    describe systemd_service('mysqld') do
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe 'Unsupported OS family' do
      it { should eq 'Unsupported OS family' }
    end
  end  
end
