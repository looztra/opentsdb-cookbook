include_recipe 'opentsdb::prepare'


hbase_home = "#{node['opentsdb']['hbase_installdir']}/hbase"
directory node['opentsdb']['hbase_rootdir'] do
	action :create
end
directory node['opentsdb']['tgz_rootdir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node['opentsdb']['tgz_rootdir']}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz" do
  source "http://www.apache.org/dist/hbase/hbase-#{node['opentsdb']['hbase_version']}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz"
  action :create_if_missing
end

execute "tar" do
	cwd node['opentsdb']['hbase_installdir']
	command "tar xzf #{node['opentsdb']['tgz_rootdir']}/hbase-#{node['opentsdb']['hbase_version']}.tar.gz"
	creates "#{node['opentsdb']['hbase_installdir']}/hbase-#{node['opentsdb']['hbase_version']}"
end

link hbase_home do
  to "#{node['opentsdb']['hbase_installdir']}/hbase-#{node['opentsdb']['hbase_version']}"
end

template "#{hbase_home}/conf/hbase-site.xml" do
	source "hbase-conf.erb"
	mode "0644"
end

file "/etc/profile.d/hbase-opentsdb.sh" do
  content <<-EOS
    export HBASE_HOME=#{hbase_home}
  EOS
  mode 0755
end
