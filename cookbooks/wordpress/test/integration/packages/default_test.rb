control 'required-packages' do
  title 'Ensure required packages are installed'
  desc 'This control ensures that packages are installed.'

  describe package('apache2') do
    it { should be_installed }
  end

  describe package('php') do
    it { should be_installed }
  end

  describe package('php-mysql') do
    it { should be_installed }
  end

  describe package('libapache2-mod-php') do
    it { should be_installed }
  end

  describe package('php-curl') do
    it { should be_installed }
  end
end
