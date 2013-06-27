node['opentsdb']['packager_recipes'].each() do | recipe |
	include_recipe recipe
end

include_recipe "ntp"
include_recipe "java"

package_list = Array.new(node['opentsdb']['tools'])
package_list.push('gnuplot')
package_list.push('git')

package_list.each do |pkg|
	package pkg
end

service "iptables" do
	action [:disable, :stop]
end
