# include Chef::Mixin::Shellout
::Chef::Recipe.send(:include, Chef::Mixin::ShellOut)


if shell_out("ps auxwww | grep 'org.apache.hadoop.hbase.master.HMaster start' | grep -v grep | wc -l").stdout.chomp == "1"
	hbase_is_up=true
	log "HBASE seems started (from start_hbase) "
else
	hbase_is_up=false
	log "HBASE does not seem started, we will start it (from start_hbase) "
end

execute "start hbase if needed" do
	command "#{node['opentsdb']['hbase_installdir']}/hbase/bin/start-hbase.sh" 
	not_if { hbase_is_up }
	environment ({'HBASE_HOME' => "#{node['opentsdb']['hbase_installdir']}/hbase"})
end
