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

if node['opentsdb']['proxy']['enabled']
	log "Setting proxy configuration for git"	
	custom_env = Hash.new
	custom_env['http_proxy'] = node['opentsdb']['proxy']['http_proxy']
	custom_env['https_proxy'] = node['opentsdb']['proxy']['https_proxy']	
else
	log "No proxy configuration"
	custom_env = Hash.new
end



directory node['opentsdb']['tsdb_cachedir'] do
	action :create
end

if node['opentsdb']['build_from_src']
	log 'Building OpentTSDB from source'
	execute "git clone opentsdb" do
		cwd node['opentsdb']['tsdb_installdir']
		command "git clone -b #{node['opentsdb']['tsdb_branch']} #{node['opentsdb']['tsdb_repo']}"
		creates "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
		environment custom_env
	end	
	execute "build opentsdb" do
		cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
		command "./build.sh"
		not_if "test -f #{node['opentsdb']['tsdb_installdir']}/opentsdb/build/tsdb-*.jar"
		environment custom_env
	end
	execute "initialize database" do
		cwd "#{node['opentsdb']['tsdb_installdir']}/opentsdb"
		command "./src/create_table.sh"
		custom_env['COMPRESSION']='NONE'
		custom_env['HBASE_HOME']='/usr/local/hbase'
		not_if "echo 'list' | /usr/local/hbase/bin/hbase shell | grep tsdb-uid"
		environment custom_env
	end
else
	log 'Skipping the build of OpentTSDB from source'
end
