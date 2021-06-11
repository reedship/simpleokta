# Simpleokta

This gem provides easy access to multiple common Okta API calls. Please see the (documentation on rubydoc)[https://www.rubydoc.info/github/bradenshipley/simpleokta/main] for more information on what methods are available.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simpleokta'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simpleokta

## Usage

Pass in the `api_token` and `base_api_url` of your okta instance as a hash into the `Client` initializer.

```ruby
config = {
  :api_token => "API_TOKEN HERE",
  :base_api_url => "URL HERE." #EX: 'https://dev-123456.okta.com'
}
@okta_util = Simpleokta::Client.new(config)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simpleokta. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/simpleokta/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Simpleokta project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simpleokta/blob/master/CODE_OF_CONDUCT.md).
