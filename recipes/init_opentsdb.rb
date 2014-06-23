# include Chef::Mixin::Shellout
::Chef::Recipe.send(:include, Chef::Mixin::ShellOut)

log 'Creating OpenTSDB HBase tables if needed'

if shell_out("test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid").exitstatus == 0
	tsdb_hbase_tables_exist=true
	log "tsdb HBASE tables exist, we won't try to create them (from init_opentsdb)"
else
	tsdb_hbase_tables_exist=false
	log "tsdb HBASE tables do not exist, we should create them (from init_opentsdb)"
end
#
# we sleep 15 seconds to let HBase master start
#
execute "create OpenTSDB hbase tables" do
	cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
	command "sleep 15 && ./src/create_table.sh >> /var/log/hbase.create_tsdb_tables.log 2>&1"
	not_if  { tsdb_hbase_tables_exist }
	environment ({'HBASE_HOME' => "#{node['opentsdb']['hbase_installdir']}/hbase", "COMPRESSION" => "none"})
end