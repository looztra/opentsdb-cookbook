execute "start hbase if needed" do
	command "#{node['opentsdb']['hbase_installdir']}/hbase/bin/start-hbase.sh" 
	not_if "ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep"
	environment ({'HBASE_HOME' => "#{node['opentsdb']['hbase_installdir']}/hbase"})
end
