
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
$ bundle install
...
```

Next, you can look at the predefined Rake tasks:
```
$ rake -T
rake codestyle    # check code style with rubocop
rake foodcritic   # run foodcritic lint checks
rake integration  # run test-kitchen integration tests
rake release      # release the cookbook (metadata, tag, push)
rake spec         # run chefspec examples
rake test         # run all unit-level tests
```

For example, you can run `rake test` to run all the unit level spec tests and linting checks.
```
$ rake test
...
```

Or you run `rake integration` to run all the kitchenci integration tests.
```
$ rake integration
...
```

### Integration Testing with Docker

As we all know running the kitchenci integration tests on VirtualBox takes a while, but we can do better. Running them with Docker gives you a way much faster turnaround. So here's how to do it:
```
$ set VAGRANT_DEFAULT_PROVIDER=docker
$ set KITCHEN_LOCAL_YAML=.kitchen.docker.yml
$ rake integration
...
```

If you are running on Windows, you can use this too! Make sure you have the latest version of the [Bill's Kitchen DevPack](https://github.com/tknerr/bills-kitchen) and run `b2d-start` to start the boot2docker VM in the background (it will act as a remote docker host in this case).

## Contributing

## License
