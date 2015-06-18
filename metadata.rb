name 'jenkins-simple-app'
maintainer 'Torben Knerr'
maintainer_email 'torben.knerr@zuehlke.com'
license 'mit'
description 'Installs/Configures jenkins-simple-app'
long_description 'Installs/Configures jenkins-simple-app'
version '0.1.0'

# for the master
depends 'jenkins', '2.3.1'
depends 'git', '4.2.2'
depends 'apt', '2.7.0'

# for the slaves
depends 'java', '1.31.0'
depends 'maven', '1.3.0'
