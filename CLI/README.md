# JBADMIN - CLI
- CLI Admin Utility

Simple CLI Admin Utility for keeping track of and pinging servers.

## Installation

Install Dependencies:

    $ bundle

Run Locally:

    $ bundle exec Jbadmin

Or install it yourself as:

    $ rake build
    $ rake install

## Usage

Initialize, Add Computer & Run Commands
```
# Initialize config - this command setups .jbadmin folder in your home directory
$ jbadmin init

# store frequently used remote computers to the db
            [NAME] [IP]           [USER]   
$ jbadmin add master 192.168.56.110 vagrant

# Ping
            [NAME]    [COMMAND]
$ jbadmin ping host

```

```
Name: Jbadmin
Version: 0.2.0
Info: CLI Utility for running commands on remote machines / downloading & uploading files via SSH/SCP

Commands:
  jbadmin add [HOST] [IP] [USER]             # add computer
  jbadmin delete [HOST]                      # delete computer
  jbadmin help [COMMAND]                     # Describe available commands or one specific command
  jbadmin init                               # initialize config & storage
  jbadmin list                               # list all computers
  jbadmin ping [HOST]                        # pings server or all
  jbadmin update [HOST] [FIELD] [NEW_VALUE]  # update computer
  jbadmin version | -v | --version           # version
```

### Notes/TODO
- create .pub key copy / install public key
- ssh

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbcool17/Jbadmin.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
