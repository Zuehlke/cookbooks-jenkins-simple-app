require 'spec_helper'

describe 'jenkins-simple-app::default' do
  #
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  #
  it 'starts the jenkins service' do
    service('jenkins').should be_running
  end
  it 'enables the jenkins service on startup' do
    service('jenkins').should be_enabled
  end
  it 'runs jenkins on port 8080' do
    port(8080).should be_listening
  end

  it 'installs jenkins version 1.609.1' do
    cmd = command('wget -qO- localhost:8080')
    cmd.stdout.should include 'Jenkins ver. 1.609.1'
  end

end
