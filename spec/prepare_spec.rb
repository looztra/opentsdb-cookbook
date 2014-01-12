require "chefspec"


describe "opentsdb::prepare" do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'opentsdb::prepare' }
  it "includes ntp" do
    expect(chef_run).to include_recipe "ntp::default"
  end
end