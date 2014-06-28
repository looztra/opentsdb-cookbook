require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "HBase Daemon" do

  it "is listening on port 60010 (webui)" do
    expect(port(60010)).to be_listening
  end

  it "is listening on port 2181 (zookeeper)" do
    expect(port(2181)).to be_listening
  end

end