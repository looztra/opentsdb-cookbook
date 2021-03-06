#
# Cookbook Name:: opentsdb
# Recipe:: intall
#
#
# Author:: Christophe Furmaniak
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'opentsdb::prepare'

directory node['opentsdb']['tsdb_cachedir'] do
	action :create
end

if node['opentsdb']['build_from_src']
	log 'Building OpentTSDB from source'
	execute "git clone opentsdb" do
		cwd node['opentsdb']['tsdb_installdir']
		command "git clone -b #{node['opentsdb']['tsdb_branch']} #{node['opentsdb']['tsdb_repo']}"
		creates "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
	end	
	execute "build opentsdb" do
		cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
		command "./build.sh"
		not_if "test -f #{node['opentsdb']['tsdb_installdir']}/opentsdb/build/tsdb-*.jar"
	end
else
	log 'Skipping the build of OpentTSDB from source'
end

template "/home/vagrant/start_tsdb.sh" do
  source "start_tsdb.sh.erb"
  mode "0755"
end
