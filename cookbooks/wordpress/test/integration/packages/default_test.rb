control 'required-packages' do
  title 'Ensure required packages are installed'
  desc 'This control ensures that packages are installed.'

  describe package('php') do
    it { should be_installed }
  end

  if os.family == 'debian'
    describe package('apache2') do
      it { should be_installed }
    end

    describe package('php-mysql') do
      it { should be_installed }
    end
  elsif os.family == 'redhat'
    describe package('httpd') do
      it { should be_installed }
    end

    describe package('php-mysqlnd') do
      it { should be_installed }
    end
  else
    describe 'Unsupported OS family' do
      it { should eq 'Unsupported OS family' }
    end
  end
end
