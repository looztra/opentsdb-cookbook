# include Chef::Mixin::Shellout
::Chef::Recipe.send(:include, Chef::Mixin::ShellOut)

log 'Creating OpenTSDB HBase tables if needed'

if shell_out("ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep | wc -l").stdout.chomp == "1"
	hbase_is_up=true
	log "(init_opentsdb) HBASE seems started"
else
	hbase_is_up=false
	log "(init_opentsdb) HBASE does not seem started, we won't try to create the tables"
end

if shell_out("test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid").exitstatus == 0
	tsdb_hbase_tables_exist=true
	log "(before) tsdb HBASE tables exist, we won't try to create them"
else
	tsdb_hbase_tables_exist=false
	log "(before) tsdb HBASE tables do not exist, we should create them"
end


execute "create OpenTSDB hbase tables" do
	cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
	command "./src/create_table.sh >> /var/log/hbase.create_tsdb_tables.log 2>&1"
	only_if { hbase_is_up }
	not_if  { tsdb_hbase_tables_exist }
	environment ({'HBASE_HOME' => "#{node['opentsdb']['hbase_installdir']}/hbase", "COMPRESSION" => "none"})
end

if shell_out("test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid").exitstatus == 0
	log "(after) tsdb HBASE tables exist, w00t"
else
	log "(after) tsdb HBASE tables do not exist, check logs"
end
