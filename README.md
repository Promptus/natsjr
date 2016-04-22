# NatsJr

[![Build Status](https://travis-ci.org/Promptus/natsjr.svg?branch=master)](https://travis-ci.org/Promptus/natsjr)
[![Code Climate](https://codeclimate.com/github/Promptus/natsjr/badges/gpa.svg)](https://codeclimate.com/github/Promptus/natsjr)

This is a tiny microframework built on top of the NATS message queue.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'natsjr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install natsjr

## Usage

Environment is set using `NATSJR_ENV` environmnet variable.

Your project directory should contain `config/config.yml` looking something like:

```yml
development:                   # Environment
  group: "group_name"          # Group name for message handling, defaults to namespace
  handlers: 3                  # Number of subscribtions to handle, defaults to cpu count
  namespace: "some_namespace"  # Namespace to use, defaults to empty string
  nats_servers:                # Defaults to "0.0.0.0:4222"
    - "0.0.0.0:4222"
```

All keys are others are optional and fall back to sensible augmented defaults.


```ruby
require "bundler/setup"
require "natsjr"

module MyService
  include NatsJr::Server

  # Request expects response and must return a hash
  respond(to: "hello") do |payload|
    # Do stuff
    payload # { hello: "world" }
  end

  # Request was fire and forget, issued using `publish`
  listen(to: "hello") do
    # Do stuff
    puts "Hello world"
  end
end

MyService.run!
```

## To be done

□ Introduce namespace call #1

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/promptus/natsjr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

