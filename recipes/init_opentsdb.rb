log 'Creating OpenTSDB HBase tables if needed'
execute "create OpenTSDB hbase tables" do
	cwd "#{node['opentsdb']['opentsdb_installdir']}/opentsdb"
	command "env COMPRESSION=none HBASE_HOME=#{node['opentsdb']['hbase_installdir']}/hbase ./src/create_table.sh"
	only_if "ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep"
	not_if "test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid"	
end
