
log 'Creating OpenTSDB HBase tables if needed'
log "executing command: ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep"
if system("ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep")
	log "HBASE seems started"
else
	log "HBASE does not seem started"
end

log "executing command: test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid"
if system("test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid")
	log "(before) tsdb HBASE tables does not exist"
else
	log "(before) tsdb HBASE tables exist"
end


execute "create OpenTSDB hbase tables" do
	cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
	command "./src/create_table.sh"
	only_if "ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep"
	not_if "test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid"	
	environment ({'HBASE_HOME' => "#{node['opentsdb']['hbase_installdir']}/hbase", "COMPRESSION" => "none"})
end

if system("test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb && test -d #{node['opentsdb']['hbase_rootdir']}/hbase-root/hbase/tsdb-uid")
	log "(after) tsdb HBASE tables does not exist"
else
	log "(after) tsdb HBASE tables exist"
end
