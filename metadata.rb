name             'opentsdb'
license          'Apache v2.0'
description      'Installs/Configures opentsdb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
maintainer       "Christophe Furmaniak"
maintainer_email "christophe.furmaniak@gmail.com"
depends			 "yum"
depends			 "ntp"
depends			 "java"
recipe 			 "default", "see install recipe"
recipe 			 "prepare", "Install and setup requirements (ntp, package manager, java)"
recipe 			 "install", "Install HBase and OpenTSDB from source"
recipe			 "opentsdb", "Start tsd daemon"
recipe			 "tcollector", "Install and start tcollector"

%w{ centos }.each do |os|
  supports os
end
