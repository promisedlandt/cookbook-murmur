include_recipe "runit"

runit_service "murmur" do
  owner node[:murmur][:user]
  group node[:murmur][:group]
  default_logger true
  action [:enable, :start]
end
