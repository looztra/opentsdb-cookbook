default['opentsdb']['ifcfg'] = 'lo'
default['opentsdb']['user'] = 'root'
default['opentsdb']['tgz_rootdir'] = '/tmp/tgz'
# HBase stuff
default['opentsdb']['hbase_rootdir'] = '/var/spool/tsdhbase'
default['opentsdb']['hbase_installdir'] = '/usr/local'
default['opentsdb']['hbase_version'] = '0.94.8'
# OpenTSDB stuff
default['opentsdb']['opentsdb_installdir'] = '/usr/local'
default['opentsdb']['tsdb_cachedir']='/var/cache/tsdb'
default['opentsdb']['repo'] = 'git://github.com/OpenTSDB/opentsdb.git'
default['opentsdb']['branch'] = 'master'
default['opentsdb']['build_from_src'] = true
default['opentsdb']['tsdb_port'] = 4242
default['opentsdb']['tsdb_autometrics'] = true
# tcollector stuff
default['opentsdb']['tcollector_repo'] = 'https://github.com/OpenTSDB/tcollector.git'
default['opentsdb']['tcollector_installdir'] = '/usr/local'
# default tools
default['opentsdb']['tools'] = ["nc","htop","sysstat"]
# packaging tool 
if platform_family?("rhel")
  default['opentsdb']['packager_recipes'] = ['yum','yum::epel']
end


