default['opentsdb']['ifcfg'] = 'lo'
default['opentsdb']['user'] = 'root'
# HBase stuff
default['opentsdb']['hbase_rootdir'] = '/var/spool/tsdhbase'
default['opentsdb']['hbase_installdir'] = '/usr/local'
default['opentsdb']['hbase_version'] = '0.94.26'
# OpenTSDB stuff
default['opentsdb']['tsdb_installdir'] = '/usr/local'
default['opentsdb']['tsdb_cachedir'] ='/var/cache/tsdb'
default['opentsdb']['tsdb_repo'] = 'https://github.com/OpenTSDB/opentsdb.git'
default['opentsdb']['tsdb_branch'] = 'master'
default['opentsdb']['build_from_src'] = true
default['opentsdb']['tsdb_port'] = 4242
default['opentsdb']['tsdb_autometrics'] = true
# tcollector stuff
default['opentsdb']['tcollector_repo'] = 'https://github.com/OpenTSDB/tcollector.git'
default['opentsdb']['tcollector_installdir'] = '/usr/local'
# elasticsearch stuff (for grafana)
default['elasticsearch']['cluster']['name'] = 'es_for_grafana'
# grafana
default['grafana']['install_flavour'] = 'release'
default['grafana']['nginx']['install_recipe'] = 'default'
default['opentsdb']['grafana_host'] = 'localhost'
default['opentsdb']['tsdb_host'] ='localhost'
default['opentsdb']['tsdb_cors_fixed_port'] = 4243
default['grafana']['datasources'] = {
	'opentsdb' => { 'type' => 'opentsdb', 'url' => "'http://'+window.location.hostname+':#{node['opentsdb']['tsdb_cors_fixed_port']}'", 'default' => 'true'},
}
# packaging tool 
if platform_family?("rhel")
  default['opentsdb']['packager_recipes'] = ['yum','yum-epel']
  # default tools
  default['opentsdb']['tools'] = ["nc","htop","sysstat","autoconf","automake"]
elsif platform_family?("debian")
  default['opentsdb']['packager_recipes'] = ['apt']
  # default tools
  default['opentsdb']['tools'] = ["netcat","htop","sysstat","autoconf","automake"]
else
  default['opentsdb']['packager_recipes'] = nil
end


