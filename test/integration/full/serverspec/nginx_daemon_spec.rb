require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "nginx Daemon" do

  describe package('nginx') do
    it { should be_installed }
  end

  describe file('/etc/nginx/sites-enabled/grafana.conf') do
    it { should be_file }
    its(:content) { should match /listen *80 	default;/ }
  end

  describe file('/etc/nginx/sites-enabled/opentsdb-cors-fix.conf') do
    it { should be_file }
    its(:content) { should match /upstream opentsdb/ }
    its(:content) { should match /listen \*:4243;/ }
  end

  it "is listening on port 80" do
    expect(port(80)).to be_listening
  end

  it "is listening on port 4243" do
    expect(port(4243)).to be_listening
  end


end