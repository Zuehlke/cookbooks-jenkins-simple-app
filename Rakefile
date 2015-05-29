require 'bundler/setup'

desc 'run foodcritic lint checks'
task :foodcritic do
  sh 'foodcritic -f any .'
end

desc 'check code style with rubocop'
task :codestyle do
  sh 'rubocop . --format progress --format offenses'
end

desc 'run chefspec examples'
task :spec do
  sh 'rspec --format doc --color'
end

desc 'run test-kitchen integration tests'
task :integration do
  sh 'kitchen test --log-level info'
end

desc 'run all unit-level tests'
task :test => [:foodcritic, :codestyle, :spec]

desc 'release the cookbook (metadata, tag, push)'
task :release do
  print 'This will create and push a tag with the version from `metadata.rb`. Continue? [y/n] '
  if (STDIN.gets.chomp).match(/^[yY][eE]?[sS]?$/)
    sh 'stove --log-level info'
  else
    puts 'release aborted'
  end
end
