control 'required-packages' do
  title 'Ensure required packages are installed'
  desc 'This control ensures that packages are installed.'

  describe package('nginx') do
    it { should be_installed }
  end
end
