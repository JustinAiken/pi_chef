#
# Cookbook Name:: my_pi
# Recipe:: network
#
# Copyright 2015, Justin Aiken
#

template '/etc/network/interfaces' do
  owner 'root'
  group 'root'
  mode 0645
  source 'interfaces.erb'
end
