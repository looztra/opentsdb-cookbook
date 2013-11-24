name             'opentsdb'
license          'Apache v2.0'
description      'Installs/Configures opentsdb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
maintainer       "Christophe Furmaniak"
maintainer_email "christophe.furmaniak@gmail.com"
depends			 "yum"
depends			 "apt"
depends			 "ntp"
depends			 "java"
recipe 			 "default", "see install recipe"
recipe 			 "prepare", "Install and setup requirements (ntp, package manager, java)"
recipe 			 "install", "Install HBase, OpenTSDB and tcollector from source"
recipe			 "start", "Start hbase, tsd and tcollector daemons"
recipe 			 "install_hbase", "Install HBase"
recipe 			 "install_opentsdb", "Install Opentsdb"
recipe 			 "install_tcollector", "Install tcollector"
recipe 			 "start_hbase", "Start HBase"
recipe 			 "start_opentsdb", "Start Opentsdb"
recipe 			 "start_tcollector", "Start tcollector"

%w{ centos }.each do |os|
  supports os
end
