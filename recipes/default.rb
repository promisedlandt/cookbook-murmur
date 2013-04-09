node.set[:murmur][:service_to_be_notified] = if node[:murmur][:init_style] == "runit"
                                                  "runit_service[murmur]"
                                                else
                                                  "service[murmur]"
                                                end

include_recipe "apt"

node[:murmur][:prereq_packages].each do |pkg|
  package pkg
end

# Create system user and group
group node[:murmur][:group]

user node[:murmur][:user] do
  group node[:murmur][:group]
  system true
  shell "/bin/bash"
end

[ node[:murmur][:home_dir],
  node[:murmur][:database_dir],
  node[:murmur][:config_dir] ].each do |dir|

  directory dir do
    mode 00755
    owner node[:murmur][:user]
    group node[:murmur][:group]
    recursive true
  end
end

template ::File.join(node[:murmur][:config_dir], "murmur.ini") do
  source "murmur.ini.erb"
  backup false
  mode 00600
  owner node[:murmur][:user]
  group node[:murmur][:group]
  variables :config => node[:murmur][:config][:variables]
  cookbook node[:murmur][:config][:config_file_cookbook] if node[:murmur][:config][:config_file_cookbook]
  notifies :restart, node[:murmur][:service_to_be_notified] if node[:murmur][:service_to_be_notified]
end

cookbook_file ::File.join(node[:murmur][:database_dir], "murmur.sqlite") do
  backup false
  mode 00600
  owner node[:murmur][:user]
  group node[:murmur][:group]
  cookbook node[:murmur][:database_file_cookbook]
  action :create_if_missing
  only_if { node[:murmur][:database_file_cookbook] }
end

# Install the application
if ["package"].include?(node[:murmur][:install_style])
  include_recipe "murmur::_install_#{ node[:murmur][:install_style] }"
else
  Chef::Log.error("murmur: installation method not recognized or set: #{ node[:murmur][:install_style] }")
end

# Which init style do we want to use?
if ["runit", "sysv"].include?(node[:murmur][:init_style])
  include_recipe "murmur::_init_#{ node[:murmur][:init_style] }"
else
  Chef::Log.warn("murmur: init style not recognized or set: #{ node[:murmur][:init_style] }")
end

execute "set-murmur-superuser-password" do
  command "murmurd -ini #{ ::File.join(node[:murmur][:config_dir], "murmur.ini") } -supw #{ node[:murmur][:superuser_password] }"
  only_if { node[:murmur][:superuser_password] }
end
