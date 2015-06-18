#
# Cookbook Name:: jenkins-simple-app
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Torben Knerr
#

# refresh apt cache
include_recipe 'apt'

# install jenkins
node.set['git']['version'] = '1.9.1'
include_recipe 'git'

# XXX: this currently fails with older versions due to https://issues.jenkins-ci.org/browse/INFRA-77
# => could be fixed via http://stackoverflow.com/a/9898849/2388971
node.set['jenkins']['master']['install_method'] = 'package'
node.set['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian-stable'
node.set['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
node.set['jenkins']['master']['version'] = '1.609.1'
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

# configure job
if node['jenkins_simple_app']['git_repository_url']
  xml = File.join(Chef::Config[:file_cache_path], 'JenkinsSeedJob-config.xml')

  template xml do
    source 'JenkinsSeedJob.xml.erb'
  end

  # Create a jenkins job (default action is `:create`)
  jenkins_job 'SeedJob' do
    config xml
  end

  # run the seed buildjob
  http_request 'execute_seed_Job' do
    url 'http://localhost:8080/job/SeedJob/build?delay=0sec'
    action :get
  end
end

# block until jenkins is up & ready
ruby_block 'block_until_operational' do
  block do
    until IO.popen('netstat -lnt').entries.select { |e| e.split[3] =~ /:8080$/ }.size == 1
      Chef::Log.debug 'service[jenkins] not listening on port 8080'
      sleep 1
    end
    loop do
      url = URI.parse('http://localhost:8080/job/SeedJob/config.xml')
      res = Chef::REST::RESTRequest.new(:GET, url, nil).call
      break if res.is_a?(Net::HTTPSuccess) || res.is_a?(Net::HTTPNotFound)
      Chef::Log.debug "service[jenkins] not responding OK to GET /job/SeedJob/config.xml #{res.inspect}"
      sleep 1
    end
  end
  subscribes :create, 'service[jenkins]', :immediately
end
