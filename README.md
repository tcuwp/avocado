# Avocado

A collection of authentication tools for use in [Rails] 7.1+ applications.

## Installation

With bundler, add to the application's Gemfile by executing:

    $ bundle add avocado

Without bundler, install the gem by executing:

    $ gem install avocado

## Usage

If you have a `User` model in your application and are nervous about using Rails
features directly, preferring to consume the features via a packaged gem, add
the `Avocado::User` to your `User` model:

```ruby
class User < ApplicationRecord
  include Avocado::User
end
```

This will do a few things behind the scenes:

- Use the built-in `has_secure_password` to generate relevant password methods
- Add some basic validations for the `email` and `password` fields on `User`
- Normalize email values when records are saved
- Provide signed token generators for `password_recovery`, `email_verification`,
  and `email_affirmation`

It's sort of funny to do this because you genuinely just could have put this
stuff right in your app, and yet here we are making gems instead!

There is an `Avocado::Mailer` which can be included in a mailer class and
provides some basic mailers.

The `spec/internal` app within this repo has some example usage of both model
and mailer.

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
