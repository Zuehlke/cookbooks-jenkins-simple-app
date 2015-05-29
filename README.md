
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

As we all know running the kitchenci integration tests on VirtualBox takes a while, but we can do better. Running them with Docker gives you a way much faster turnaround. So here's how to do it.

Option 1) using the [kitchen-docker](https://github.com/portertech/kitchen-docker) driver:
```
$ set KITCHEN_LOCAL_YAML=.kitchen.docker.yml
$ rake integration
...
```

Option 2) using the [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant) driver:
```
$ vagrant box add opscode-ubuntu-14.04 https://atlas.hashicorp.com/tknerr/boxes/baseimage-ubuntu-14.04/versions/1.0.0/providers/docker.box --provider=docker
$ set VAGRANT_DEFAULT_PROVIDER=docker
$ rake integration
...
```

The differences are subtle: while 1) is more lightweight and starts up faster, 2) can cache downloaded files via vagrant-cachier.

### Developing on Windows

If you are running on Windows, you can use Docker  too! Make sure you have the latest version of the [Bill's Kitchen DevPack](https://github.com/tknerr/bills-kitchen), then:

* run `b2d-start` to start the boot2docker VM in the background (it will act as a remote docker host)
* access the docker containers via 192.168.59.103 (the `boot2docker ip`) instead of localhost

## Contributing

## License
