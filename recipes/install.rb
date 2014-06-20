include_recipe "opentsdb::install_hbase"
include_recipe "opentsdb::install_opentsdb"
include_recipe "opentsdb::install_tcollector"

cookbook_file "/home/vagrant/start_all.sh" do
  source "start_all.sh"
  mode 0755
end
