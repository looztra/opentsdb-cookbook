execute "Starting tcollector if needed" do
	command "#{node['opentsdb']['tcollector_installdir']}/tcollector/startstop start"
	not_if "ps auxwww | grep -v grep | grep tcollector.py"
	environment  ({'TSD_HOST' => 'localhost'})
end