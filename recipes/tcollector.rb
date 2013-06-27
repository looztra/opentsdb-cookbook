if node['opentsdb']['proxy']['enabled']
	log "Setting proxy configuration for git"	
	custom_env = Hash.new
	custom_env['http_proxy'] = node['opentsdb']['proxy']['http_proxy']
	custom_env['https_proxy'] = node['opentsdb']['proxy']['https_proxy']	
else
	log "No proxy configuration"
	custom_env = Hash.new
end

log 'Installing tcollector if needed'
execute "git clone tcollector" do
	cwd node['opentsdb']['tcollector_installdir']
	command "git clone #{node['opentsdb']['tcollector_repo']}"
	creates "#{node['opentsdb']['tcollector_installdir']}/tcollector"
	environment custom_env
end

template "#{node['opentsdb']['tcollector_installdir']}/tcollector/collectors/0/tsdb_stats.sh" do
	source "tsdb_stats.sh.erb"
	mode "0755"
end

execute "tcollector" do
  command "env TSD_HOST=localhost #{node['opentsdb']['tcollector_installdir']}/tcollector/startstop start"
  not_if "ps auxwww | grep -v grep | grep tcollector.py"
end