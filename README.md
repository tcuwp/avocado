# Avocado

A collection of authentication tools for use in [Rails] 7.1 applications.
Provides basic identity features which are lightweight wrappers around built-in
Rails framework libaries:

- Create basic User (email + password) records
- Session management with multiple device support
- Event logging creates a user activity audit trail
- Mailers for password recovery, passwordless sign in, and email verification

## Installation

Add to the application's Gemfile by executing:

    $ bundle add avocado

## Usage

If you are nervous about using Rails features directly, preferring to consume
such features via a packaged gem, you're in luck -- that's what Avocado does!

Read the [documentation] for more details.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Running `bundle exec rake` will run the full spec suite and a linter.

## Contributing

Bug reports and pull requests are welcome on [GitHub].

## License

The gem is available as open source under the terms of the [MIT License].

[documentation]: https://github.com/tcuwp/avocado/blob/main/docs/USAGE.md
[GitHub]: https://github.com/tcuwp/avocado
[MIT License]: https://opensource.org/licenses/MIT
[Rails]: https://github.com/rails/rails
