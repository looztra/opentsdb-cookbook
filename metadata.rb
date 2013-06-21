name             'opentsdb'
license          'Apache v2.0'
description      'Installs/Configures opentsdb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
maintainer       "Christophe Furmaniak"
maintainer_email "christophe.furmaniak@gmail.com"
depends			 "yum"
recipe 			 "opentsdb", "Installs HBase and OpenTSDB from source"

%w{ centos }.each do |os|
  supports os
end
