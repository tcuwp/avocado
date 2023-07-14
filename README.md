# Avocado

A collection of authentication tools for use in [Rails] 7.1+ applications.

## Installation

With bundler, add to the application's Gemfile by executing:

    $ bundle add avocado

Without bundler, install the gem by executing:

    $ gem install avocado

## Usage

If you have a `User` model in your application and are nervous about using Rails
features directly, preferring to consume the features via a packaged gem, you
can use the Rails `has_secure_password` feature in a more convoluted way, by
adding the `Avocado::UserConcer` to your `User` model:

```ruby
class User < ApplicationRecord
  include Avocado::UserConcern
end
```

Note that behind the scenes this is truly just calling `has_secure_password` for
you and doing nothing else. It's sort of funny to do this.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to [RubyGems].

## Contributing

Bug reports and pull requests are welcome on [GitHub].

## License

The gem is available as open source under the terms of the [MIT License].

[GitHub]: https://github.com/tcuwp/avocado
[MIT License]: https://opensource.org/licenses/MIT
[Rails]: https://github.com/rails/rails
[RubyGems]: https://rubygems.org
