require 'spec_helper'

describe 'jenkins-simple-app::default' do
  #
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  #

  it 'starts the jenkins service' do
    expect(service('jenkins')).to be_running
  end
  it 'enables the jenkins service on startup' do
    expect(service('jenkins')).to be_enabled
  end
  it 'runs jenkins on port 8080' do
    expect(port(8080)).to be_listening
  end

  it 'installs jenkins version 1.609.1' do
    cmd = command('wget -qO- localhost:8080')
    expect(cmd.stdout).to include 'Jenkins ver. 1.609.1'
  end

  it 'installs some jenkins plugins' do
    query_params = 'depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins'
    response = command("wget -qO- 'localhost:8080/pluginManager/api/xml?#{query_params}'").stdout
    verify_plugin_installed response, 'git', '2.3.5'
    verify_plugin_installed response, 'greenballs', '1.14'
    verify_plugin_installed response, 'ansicolor', '0.4.1'
    verify_plugin_installed response, 'chucknorris', '0.5'
    verify_plugin_installed response, 'envinject', '1.91.3'
    verify_plugin_installed response, 'job-dsl', '1.34'
    verify_plugin_installed response, 'jobConfigHistory', '2.11'
    verify_plugin_installed response, 'build-name-setter', '1.3'
    verify_plugin_installed response, 'delivery-pipeline-plugin', '0.9.4'
    verify_plugin_installed response, 'parameterized-trigger', '2.26'
    verify_plugin_installed response, 'rebuild', '1.24'
  end

  def verify_plugin_installed(response, plugin, version)
    expect(response).to include "<shortName>#{plugin}</shortName><version>#{version}</version>"
  end

  it 'git version installed' do
    expect(command('git --version').stdout).to include 'git version 1.9.1'
  end

  it 'jenkins package installed' do
    expect(package('jenkins')).to be_installed.with_version('1.609.1')
  end

  it 'created the seed job in jenkins' do
    cmd = command('wget -qO- localhost:8080/api/xml')
    expect(cmd.stdout).to include '<name>SeedJob</name>'
  end
end
