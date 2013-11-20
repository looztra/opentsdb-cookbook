default['opentsdb']['ifcfg'] = 'lo'
default['opentsdb']['user'] = 'root'
# HBase stuff
default['opentsdb']['hbase_rootdir'] = '/var/spool/tsdhbase'
default['opentsdb']['hbase_installdir'] = '/usr/local'
default['opentsdb']['hbase_version'] = '0.94.13'
# OpenTSDB stuff
default['opentsdb']['tsdb_installdir'] = '/usr/local'
default['opentsdb']['tsdb_cachedir']='/var/cache/tsdb'
default['opentsdb']['tsdb_repo'] = 'git://github.com/OpenTSDB/opentsdb.git'
default['opentsdb']['tsdb_branch'] = 'master'
default['opentsdb']['build_from_src'] = true
default['opentsdb']['tsdb_port'] = 4242
default['opentsdb']['tsdb_autometrics'] = true
# tcollector stuff
default['opentsdb']['tcollector_repo'] = 'https://github.com/OpenTSDB/tcollector.git'
default['opentsdb']['tcollector_installdir'] = '/usr/local'
# proxy stuff
default['opentsdb']['proxy']['enabled'] = false
default['opentsdb']['proxy']['http_proxy'] = nil
default['opentsdb']['proxy']['https_proxy'] = nil
# packaging tool 
if platform_family?("rhel")
  default['opentsdb']['packager_recipes'] = ['yum','yum::epel']
  # default tools
  default['opentsdb']['tools'] = ["nc","htop","sysstat","autoconf","automake"]
elsif platform_family?("debian")
  default['opentsdb']['packager_recipes'] = ['apt']
  # default tools
  default['opentsdb']['tools'] = ["netcat","htop","sysstat","autoconf","automake"]
else
  default['opentsdb']['packager_recipes'] = nil
end


