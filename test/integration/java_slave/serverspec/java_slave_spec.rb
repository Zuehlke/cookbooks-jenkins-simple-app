require 'spec_helper'

describe 'jenkins-simple-app::java_slave' do

  it 'installs Oracle Java 8 update 31' do
    expect(command('java -version').stderr).to include '1.8.0_31'
  end

  it 'sets JAVA_HOME correctly' do
    expect(command('bash -l -c "echo \$JAVA_HOME"').stdout).to include '/usr/lib/jvm/java-8-oracle-amd64'
  end

  it 'installs Maven 3.1.1' do
    expect(command('bash -l -c "mvn -v"').stdout).to include 'Apache Maven 3.1.1'
  end
end
