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

# install jenkins server
include_recipe 'jenkins::master'

# install plugins
plugins = {
  'git' => '2.3.5',
  'greenballs' => '1.14',
  'ansicolor' => '0.4.1',
  'chucknorris' => '0.5',
  'envinject' => '1.91.3',
  'job-dsl' => '1.34',
  'jobConfigHistory' => '2.11',
  'build-name-setter' => '1.3',
  'delivery-pipeline-plugin' => '0.9.4',
  'parameterized-trigger' => '2.26',
  'rebuild' => '1.24'
}
plugins.each do |plugin_name, plugin_version|
  jenkins_plugin plugin_name do
    version plugin_version
    notifies :restart, 'service[jenkins]', :delayed
  end
end
