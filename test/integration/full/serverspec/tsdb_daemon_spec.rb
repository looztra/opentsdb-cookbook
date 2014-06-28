require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "TSDB Daemon" do

  it "is listening on port 4242" do
    expect(port(4242)).to be_listening
  end

end