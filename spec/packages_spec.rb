require "chefspec"

describe "opentsdb::install" do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'opentsdb::install' }
  it "installs gnuplot" do
    expect(chef_run).to install_package 'gnuplot'
  end
end
