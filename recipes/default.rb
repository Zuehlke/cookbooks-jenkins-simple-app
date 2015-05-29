#
# Cookbook Name:: jenkins-simple-app
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Torben Knerr
#

node.set['jenkins']['master']['install_method'] = 'package'
node.set['jenkins']['master']['version'] = '1.615'
include_recipe 'jenkins::master'
