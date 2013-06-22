node['opentsdb']['packager_recipes'].each() do | recipe |
	include_recipe recipe
end

include_recipe "ntp"
include_recipe "java"