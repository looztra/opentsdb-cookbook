include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "mysql::ruby"
include_recipe "apache2"
include_recipe "php"

if node['opentsdb']['proxy']['enabled']
	log "Setting proxy configuration for git"	
	custom_env = Hash.new
	custom_env['http_proxy'] = node['opentsdb']['proxy']['http_proxy']
	custom_env['https_proxy'] = node['opentsdb']['proxy']['https_proxy']	
else
	log "No proxy configuration"
	custom_env = Hash.new
end

php_pear_channel 'pear.php.net' do
  action :update
end


['Auth', 'Log', 'MDB2'].each() do |pear_pkg|
	php_pear pear_pkg do
	  action :install
	end
end


sa_mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

sw_mysql_connection_info = {
  :host     => 'localhost',
  :username => node['opentsdb']['statuswolf_user'],
  :password => node['opentsdb']['statuswolf_password']
}


mysql_database node['opentsdb']['statuswolf_database'] do
  connection sa_mysql_connection_info
  action :create
end

# Create a mysql user but grant no privileges
mysql_database_user node['opentsdb']['statuswolf_user'] do
  connection sa_mysql_connection_info
  password   node['opentsdb']['statuswolf_password']
  action     :create
end

mysql_database_user node['opentsdb']['statuswolf_user'] do
  connection sa_mysql_connection_info
  action     :grant
  database_name node['opentsdb']['statuswolf_database']
end

log 'Installing statuswolf if needed'
execute "git clone statuswolf" do
	cwd node['opentsdb']['statuswolf_installdir']
	command "git clone #{node['opentsdb']['statuswolf_repo']}"
	creates "#{node['opentsdb']['statuswolf_installdir']}/StatusWolf"
	environment custom_env
end

['cache', 'cache/anomaly_model', 'cache/query_cache'].each() do |dir|
	directory "#{node['opentsdb']['statuswolf_installdir']}/StatusWolf/#{dir}" do
		action :create
		mode 01777
	end
end

mysql_database 'init statuswolf db' do
  connection sw_mysql_connection_info
  sql { ::File.open("#{node['opentsdb']['statuswolf_installdir']}/StatusWolf/conf/statuswolf.sql").read }
  action :query
end