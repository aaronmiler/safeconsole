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

`commit`:
Set the changes in the  transaction to be committed to the database

`nevermind`:
Set the changes in the transaction to be discarded

`refresh`:
Start a new transaction, and discard or commit changes based on configuration

`stats`:
Display some stats on the current Safeconsole session

`commands`:
Print the Safeconsole commands in your session


Or install it yourself as:

    $ gem install safeconsole

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aaronmiler/safeconsole. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/aaronmiler/safeconsole/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Safeconsole project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aaronmiler/safeconsole/blob/main/CODE_OF_CONDUCT.md).
