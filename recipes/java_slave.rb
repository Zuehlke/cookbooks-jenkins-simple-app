
node.set['java']['install_flavor'] = 'oracle'
node.set['java']['jdk_version'] = '8'
node.set['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe 'java'
