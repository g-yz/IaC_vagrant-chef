control 'active-services' do
  title 'Ensure required services are running and enabled'
  desc 'This control checks that important services are enabled and running on the system.'

  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('php7.4-fpm') do
    it { should be_enabled }
    it { should be_running }
  end
end
