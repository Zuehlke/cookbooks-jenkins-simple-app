#
# Cookbook Name:: jenkins-simple-app
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Torben Knerr
#

# XXX: this currently fails with older versions due to https://issues.jenkins-ci.org/browse/INFRA-77
# => could be fixed via http://stackoverflow.com/a/9898849/2388971
node.set['jenkins']['master']['install_method'] = 'package'
node.set['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian-stable'
node.set['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
node.set['jenkins']['master']['version'] = '1.609.1'

include_recipe 'jenkins::master'
