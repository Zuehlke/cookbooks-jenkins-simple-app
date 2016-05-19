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
node.set['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian'
node.set['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key'
node.set['jenkins']['master']['version'] = '2.5'
node.set['jenkins']['master']['jvm_options'] = '-Dhudson.diyChunking=false -Djenkins.install.runSetupWizard=false'
include_recipe 'jenkins::master'

# disable security which is turned on by default in jenkins 2.0
ruby_block 'disable_security' do
  block do
    config_xml = "#{node['jenkins']['master']['home']}/config.xml"
    Chef::Log.info 'Waiting until Jenkins config.xml file is present'
    until File.exist?(config_xml)
      sleep 1
      Chef::Log.debug('.')
    end
    Chef::Util::FileEdit.new(config_xml).search_file_replace_line(
      '  <useSecurity>true</useSecurity>',
      '  <useSecurity>false</useSecurity>'
    ).write_file
  end
  action :nothing
  subscribes :run, 'package[jenkins]', :immediately
  notifies :restart, 'service[jenkins]', :immediately
end

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
    until port_open? '8080'
      Chef::Log.debug 'service[jenkins] not listening on port 8080'
      sleep 1
    end
    loop do
      res = http_get('http://localhost:8080/job/SeedJob/config.xml')
      break if res.is_a?(Net::HTTPSuccess) || res.is_a?(Net::HTTPNotFound)
      Chef::Log.debug "service[jenkins] not responding OK to GET /job/SeedJob/config.xml #{res.inspect}"
      sleep 1
    end
  end
  subscribes :create, 'service[jenkins]', :immediately
end
