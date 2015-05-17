#
# Cookbook Name:: my_pi
# Recipe:: default
#
# Copyright 2015, Justin Aiken
#

include_recipe 'apt'
include_recipe 'ntp'
include_recipe 'my_pi::raspbian_cleanup'
include_recipe 'my_pi::network'
include_recipe 'git::source'
include_recipe 'rvm::system'
include_recipe 'justinaiken_dotfiles'
include_recipe 'my_pi::raspbian_java'
include_recipe 'my_pi::user_openhab'
include_recipe 'openhab'
include_recipe 'openhab::init_script'
include_recipe 'openhab::my_openhab'

%w{secret uuid}.each do |myopenhab_file|
  file "#{node[:openhab][:install_dir]}/openhab/webapps/static/#{myopenhab_file}" do
    owner node[:openhab][:user]
    group node[:openhab][:group]
    content data_bag_item('openhab', 'my_openhab')[myopenhab_file]
  end
end

include_recipe 'my_pi::openhab_config'

template '/opt/openhab/scripts/wink.sh' do
  owner node[:openhab][:user]
  group node[:openhab][:group]
  mode 0776
  source 'wink.sh.erb'
end
