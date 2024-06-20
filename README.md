# 🥑

Authentication library for [Rails] 7.1+ applications.

When most people notice the trifecta of `has_secure_password`,
`authenticate_by`, and `generates_token_for` in [Rails 7.1] they think to
themselves "Sweet sassy molassey, I bet you could DIY a nice auth solution with
these dog-gone methods!" and then they slap the roof of their cars and yell
"Everyone to the coder-cycle! Let's rev this bad boy up and build us an SDK!"

But then again, maybe it's too soon for that, or maybe you're nervous about
writing authentication code in your own application and would prefer to consume
such code in scrumpulent gem form instead. The 🥑 gem is an extraction of the
authentication portion of an experimental next-generation Rails codebase built
in our research group.

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
[wiki]: https://github.com/tcuwp/avocado/wiki
[Rails 7.1]: https://guides.rubyonrails.org/7_1_release_notes.html