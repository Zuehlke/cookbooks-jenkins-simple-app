
# Simple Jenkins Application Cookbook

An application cookbook for setting up a simple / minimal Jenkins CI server.

## Goals

 * be a minimal example that can be forked for project specific Jenkins setups
    * including testing
    * including reuse of community cookbooks
 * with the following features:
    * job definitions as code
    * standard set of useful plugins
    * master / slave configuration
    * backup / restore?

## Usage

## Development

First, you need to install the required gems:
```
W:\repo\cookbook-jenkins-simple-app>bundle install
...
```

Next, you can look at the predefined Rake tasks:
```
W:\repo\cookbook-jenkins-simple-app>rake -T
rake codestyle    # check code style with rubocop
rake foodcritic   # run foodcritic lint checks
rake integration  # run test-kitchen integration tests
rake release      # release the cookbook (metadata, tag, push)
rake spec         # run chefspec examples
rake test         # run all unit-level tests
```

For example, you can run `rake test` to run all the unit level spec tests and linting checks.

Or you run `rake integration` to run all the kitchenci integration tests.

## Contributing

## License
