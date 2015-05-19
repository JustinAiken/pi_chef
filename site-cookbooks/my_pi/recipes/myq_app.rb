#
# Cookbook Name:: my_pi
# Recipe:: myq_app
#
# Copyright 2015, Justin Aiken
#

git "/home/pi/garage" do
  repository "https://github.com/JustinAiken/garage"
  revision 'master'
  user  'pi'
  group 'pi'
  action :sync

  notifies :run, 'execute[bundle_garage_app]'
end

execute 'bundle_garage_app' do
  command "/usr/local/rvm/bin/rvm ruby-2.2.1 do /usr/bin/env bundle install"
  cwd "/home/pi/garage"
  user 'pi'
  group 'pi'
  action :nothing
end

template "/home/pi/garage/settings.yml" do
  user  'pi'
  group 'pi'
  source 'garage_settings.yml.erb'
end

cron "garage_status" do
  minute '5'
  command 'cd /home/pi/garage && /usr/local/rvm/bin/rvm ruby-2.2.1 do /usr/bin/env /home/pi/garage/bin/garage update'
end
