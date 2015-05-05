#
# Cookbook Name:: my_pi
# Recipe:: raspbian_java
#
# Copyright 2015, Justin Aiken
#

package 'oracle-java8-jdk' do
  action :install
  notifies :run, 'bash[update-java-alternatives]'
end

bash 'update-java-alternatives' do
  # code "update-java-alternatives -s jdk-8-oracle-arm-vfp-hflt"
  code %Q{update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-8-oracle-arm-vfp-hflt/jre/bin/java" 1}
  action :nothing
end
