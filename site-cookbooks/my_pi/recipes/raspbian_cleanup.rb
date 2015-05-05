#
# Cookbook Name:: my_pi
# Recipe:: raspbian_cleanup
#
# Copyright 2015, Justin Aiken
#
# Based on http://www.cnx-software.com/2012/07/31/84-mb-minimal-raspbian-armhf-image-for-raspberry-pi/

JUNK_DIRECTORIES = %w{
  /home/pi/python-games /home/pi/rubygems-1.8.10 /opt/sonic-pi /opt/vc /opt/wolfram
}

# x11-common -> needed by java???
JUNK_PACKAGES = %w{
  midori lxde python3 python3-minimal penguinspuzzle
  lxde-common lxde-icon-theme omxplayer
  libraspberrypi-doc xkb-data fonts-freefont-ttf locales
  menu menu-xdg xdg-utils desktop-file-utils raspberrypi-artwork
}

JUNK_DIRECTORIES.each do |junk_dir|
  directory junk_dir do
    action :delete
    recursive true
    ignore_failure true
  end
end

JUNK_PACKAGES.each do |pkg|
  package pkg do
    action :purge
    ignore_failure true
  end
end
