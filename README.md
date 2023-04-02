# Safeconsole

Safeconsole is a utility for a safe by default `rails console`. Every session is wrapped in an Active Record transaction, preventing accidental mutations on production data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'safeconsole'
```

And then execute:

    $ bundle install

## Usage

Start Safeconsole session by running `bin/rails safeconsole`

### Commands

The following commands are available in the Safeconsole session

- `commit`: Set the changes in the  transaction to be committed to the database
- `nevermind`: Set the changes in the transaction to be discarded
- `refresh`: Start a new transaction, and discard or commit changes based on configuration
- `stats`: Display some stats on the current Safeconsole session
- `commands`: Print the Safeconsole commands in your session

## Configuration

Safeconsole is configurable. You can configure it by adding an initializer at `config/initializers/safeconsole.rb` with the options outlined below

Example config, and options
```ruby
# config/initializers/safeconsole.rb

Safeconsole.configure do |conf|
  # App Name
  # Name of the rails app, only for display purposes in the welcome message
  # Default: Attempt to infer application name
  conf.app_name = "My Amazing Product"

  # Allow Unsafe
  # Should safe console allow unsafe consoles in the listed environments
  # Default: false
  conf.allow_unsafe = true

  # Current Environment
  # What is the current runtime environment?
  # Useful if Rails.env is `production` in staging like environments
  # Default: Rails.env
  conf.current_env = ENV["CURRENT_ENVIRONEMNT"]

  # Command Timeout
  # Should someone be removed from a console session with X duration of inactivity
  # Default: nil
  conf.command_timeout = 10.minutes

  # Session Timeout
  # What's the maximum duration someone should be allowed to run a console session?
  # Default: nil
  conf.session_timeout = 30.minutes
end
```

### Regarding Command and Session Timeouts

Both timeout configurations can be used together, independently, or not at all. Safeconsole spins up a
 background thread to monitor current session duration, to prevent hanging console sessions.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

There is a slimmed down Rails application in `spec/rails_app`, where you can run `bin/rails safeconsole` to see it in a rails app

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aaronmiler/safeconsole. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/aaronmiler/safeconsole/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Safeconsole project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aaronmiler/safeconsole/blob/main/CODE_OF_CONDUCT.md).
