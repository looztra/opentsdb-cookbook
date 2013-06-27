execute "start hbase if needed" do
	command "env HBASE_HOME=#{node['opentsdb']['hbase_installdir']}/hbase #{node['opentsdb']['hbase_installdir']}/hbase/bin/start-hbase.sh" 
	not_if "ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep"
end
