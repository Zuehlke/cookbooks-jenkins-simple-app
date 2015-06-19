
# refresh apt cache
include_recipe 'apt'

# install java
node.set['java']['install_flavor'] = 'oracle'
node.set['java']['jdk_version'] = '8'
node.set['java']['oracle']['accept_oracle_download_terms'] = true
include_recipe 'java'

# install maven
node.set['maven']['version'] = '3'
node.set['maven']['3']['version'] = '3.3.3'
node.set['maven']['install_java'] = false
node.from_file(run_context.resolve_attribute("maven", "default"))
include_recipe 'maven'
