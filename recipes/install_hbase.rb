include_recipe 'opentsdb::prepare'

tgz_dir = "#{Chef::Config[:file_cache_path]}/tgz"
hbase_home = "#{node['opentsdb']['hbase_installdir']}/hbase"
directory node['opentsdb']['hbase_rootdir'] do
	action :create
end

directory tgz_dir do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{tgz_dir}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz" do
  source "http://www.apache.org/dist/hbase/hbase-#{node['opentsdb']['hbase_version']}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz"
  action :create_if_missing
end

execute "tar" do
	cwd node['opentsdb']['hbase_installdir']
	command "tar xzf #{tgz_dir}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz"
	creates "#{node['opentsdb']['hbase_installdir']}/hbase-#{node['opentsdb']['hbase_version']}"
end

link hbase_home do
  to "#{node['opentsdb']['hbase_installdir']}/hbase-#{node['opentsdb']['hbase_version']}"
end

template "#{hbase_home}/conf/hbase-site.xml" do
	source "hbase-conf.erb"
	mode "0644"
end

file "/etc/profile.d/hbase.sh" do
  content <<-EOS
    export HBASE_HOME=#{hbase_home}
  EOS
  mode 0755
end

template "/home/vagrant/start_hbase.sh" do
  source "start_hbase.sh.erb"
  mode "0755"
end
