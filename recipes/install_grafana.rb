include_recipe "grafana::default"
include_recipe "grafana::nginx"

template "#{node['nginx']['dir']}/sites-available/opentsdb-cors-fix.conf" do
  source "opentsdb-cors-fix.conf.erb"
  mode "0644"
end

nginx_site "opentsdb-cors-fix.conf"