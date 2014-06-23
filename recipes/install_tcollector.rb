log 'Installing tcollector if needed'
execute "git clone tcollector" do
	cwd node['opentsdb']['tcollector_installdir']
	command "git clone #{node['opentsdb']['tcollector_repo']}"
	creates "#{node['opentsdb']['tcollector_installdir']}/tcollector"
end

file "/etc/profile.d/tcollector.sh" do
  content <<-EOS
    export TSD_HOST=localhost
  EOS
  mode 0755
end

template "#{node['opentsdb']['tcollector_installdir']}/tcollector/collectors/0/tsdb_stats.sh" do
	source "tsdb_stats.sh.erb"
	mode "0755"
end

template "/home/vagrant/start_tcollector.sh" do
  source "start_tcollector.sh.erb"
  mode "0755"
end
