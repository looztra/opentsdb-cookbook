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
#
include_recipe "opentsdb::init_opentsdb"


tsdb_home = "#{node['opentsdb']['opentsdb_installdir']}/opentsdb"

log "Starting opentsdb if not already running"

case node['opentsdb']['branch']
when 'master'
	log "Starting opentsdb (master)"
	execute "starting tsdb (master/v1.x)" do 
		cwd tsdb_home
		command "./build/tsdb tsd --port=#{node['opentsdb']['tsdb_port']} --staticroot=build/staticroot --cachedir=#{node['opentsdb']['tsdb_cachedir']} --auto-metric> /var/log/tsdb.log 2>&1 &"
		not_if "ps auxwww | grep 'net.opentsdb.tools.TSDMain' | grep -v grep"	
	end
when /^next/
	log "Starting opentsdb (any next branch)"
	template "#{tsdb_home}/opentsdb.conf" do
		source "opentsdb.conf.erb"
		mode "0644"
	end
	execute "starting tsdb (next/v2.x)" do 
		cwd tsdb_home
		command "./build/tsdb tsd --config #{tsdb_home}/opentsdb.conf > /var/log/tsdb.log 2>&1 &"
		not_if "ps auxwww | grep 'net.opentsdb.tools.TSDMain' | grep -v grep"	
	end
else
	log "Unsupported branch value [#{node['opentsdb']['branch']}], doing nothin"	
end
