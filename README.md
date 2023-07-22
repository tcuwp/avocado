# 🥑

If you're anything like us you like to periodically look at unreleased Rails
versions and see what sort of framework changes are coming out in the future so
that you can both enjoy and prepare for them. If you've done that, maybe you've
noticed the trifecta of `has_secure_password`, `authenticate_by`, and
`generates_token_for` in the [activerecord changelog] for what will become Rails
7.1. In that case, you've almost definitely thought to yourself "Sweet sassy
molassey, I bet you could DIY a nice auth solution with these dog-gone methods!"

But then again, maybe it's too soon for that, or maybe you're nervous about
writing authentication code in your own application and would like to consume it
in scrumpulent gem form instead. The 🥑 gem is an extraction of the
authentication portion of an experimental Rails 7.1 codebase built in our
research group.

## Installation

Add to the application's Gemfile by executing:

    $ bundle add avocado

## Usage

Read the [documentation] for more details.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Use
`bin/rspec` to run the full spec suite and `bin/standardrb` to run the linter.
Running `bin/rake` will run specs & linter.

## Contributing

Bug reports and pull requests are welcome on [GitHub].

## License

The gem is available as open source under the terms of the [MIT License].

[documentation]: https://github.com/tcuwp/avocado/blob/main/docs/USAGE.md
[GitHub]: https://github.com/tcuwp/avocado
[MIT License]: https://opensource.org/licenses/MIT
[Rails]: https://github.com/rails/rails
[activerecord changelog]: https://github.com/rails/rails/blob/main/activerecord/CHANGELOG.md
