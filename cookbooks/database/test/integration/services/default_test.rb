control 'active-services' do
  title 'Ensure required services are running and enabled'
  desc 'This control checks that important services are enabled and running on the system.'

  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
  end
end
