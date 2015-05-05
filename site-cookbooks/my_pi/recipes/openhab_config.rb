#
# Cookbook Name:: my_pi
# Recipe:: openhab_config
#
# Copyright 2015, Justin Aiken
#

DEPLOY_KEY_WRAPPER = "#{Chef::Config[:file_cache_path]}/openhab_config_deploy"
OPENHAB_CONFIG_DIR = "/opt/openhab/configurations"

file DEPLOY_KEY_WRAPPER do
  owner 'openhab'
  group 'openhab'
  mode '0755'
  content %Q{#!/bin/sh\nexec /usr/bin/ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -i /home/openhab/.ssh/id_rsa \"$@\"}
end

directory OPENHAB_CONFIG_DIR do
  action :delete
  recursive true
  ignore_failure true
  not_if { ::File.exist?("#{OPENHAB_CONFIG_DIR}/.git/config") }
end

git OPENHAB_CONFIG_DIR do
  ssh_wrapper DEPLOY_KEY_WRAPPER
  repository node[:openhab_config][:git_repository]
  revision 'master'
  user 'openhab'
  group 'openhab'
  action :sync
end
