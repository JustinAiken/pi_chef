#
# Cookbook Name:: my_pi
# Recipe:: user_openhab
#
# Copyright 2015, Justin Aiken
#
# Set up 'openhab' user and ssh goodness

user 'openhab' do
  supports manage_home: true
  gid  'openhab'
  home '/home/openhab'
  shell '/bin/bash'
  system true
end

%w{/home/openhab /home/openhab/.ssh}.each do |dir|
  directory dir do
    owner 'openhab'
    group 'openhab'
    mode 0700
    action :create
  end
end

%w{id_rsa id_rsa.pub}.each do |key_file|
  file "/home/openhab/.ssh/#{key_file}" do
    owner 'openhab'
    group 'openhab'
    mode '0600'
    content data_bag_item('openhab', 'ssh_keys')[key_file]
  end
end

ssh_known_hosts 'winkhub' do
  user 'openhab'
end

ssh_config 'winkhub' do
  user 'openhab'
  options(
    ControlMaster: 'auto',
    ControlPath:   '/tmp/openhab_ssh_mux_%h_%p_%r',
    HostName:      node[:winkhub][:ip],
    User:          'root',
    IdentityFile:  '~/.ssh/id_rsa'
  )
end

group 'openhab' do
  action :modify
  members ['openhab', 'pi']
  append true
end
