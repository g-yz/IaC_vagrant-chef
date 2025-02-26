control 'required-ports' do
  title 'Ensure required ports are open and reachable'
  desc 'This control ensures that essential ports are open and accessible.'

  describe port(8080) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end

end
