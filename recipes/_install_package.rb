template "/etc/default/mumble-server" do
  source "default.erb"
  backup false
  mode 00600
  owner node[:murmur][:user]
  group node[:murmur][:group]
end

package "mumble-server" do
  options "-o Dpkg::Options::=\"--force-confold\" --force-yes"
end
