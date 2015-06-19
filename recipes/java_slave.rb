
# refresh apt cache
include_recipe 'apt'

# install java
node.set['java']['jdk_version'] = '8'
node.set['java']['install_flavor'] = 'oracle'
node.set['java']['oracle']['accept_oracle_download_terms'] = true
node.set['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz'
node.set['java']['jdk']['8']['x86_64']['checksum'] = '173e24bc2d5d5ca3469b8e34864a80da'
include_recipe 'java'

# install maven
node.set['maven']['version'] = '3'
node.set['maven']['install_java'] = false
node.set['maven']['3']['version'] = '3.1.1'
node.set['maven']['3']['url'] = 'http://apache.mirrors.tds.net/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz'
node.set['maven']['3']['checksum'] = '077ed466455991d5abb4748a1d022e2d2a54dc4d557c723ecbacdc857c61d51b'
include_recipe 'maven'
