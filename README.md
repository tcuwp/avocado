# Avocado

A collection of authentication tools for use in [Rails] 7.1+ applications.

## Installation

Add to the application's Gemfile by executing:

    $ bundle add avocado

## Usage

If you are nervous about using Rails features directly, preferring to consume
such features via a packaged gem, you can include some Avocado modules into your
application to get authentication functionality.

As a prerequisite, you should have a database schema with columns that match the
users and sessions tables from [the demo app schema]. It's ok to have more
columns, but you need at least what is shown there.

With that set, include the modules into your classes:

```ruby
class User < ApplicationRecord
  include Avocado::User
end

class Session < ApplicationRecord
  include Avocado::Session
end

class ApplicationController < ActionController::Base
  include Avocado::Authentication
end
```

This will enable a few things:

- Models will get validations, associations, and normalizations
- Rails built-in `has_secure_password` is called within `User`
- A mailer with signed token generators is created
- Controllers/Routes created for sign up, sign in, password reset, etc

The `spec/internal` app within this repo has some example usage.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on [GitHub].

## License

The gem is available as open source under the terms of the [MIT License].

[GitHub]: https://github.com/tcuwp/avocado
[MIT License]: https://opensource.org/licenses/MIT
[Rails]: https://github.com/rails/rails
[the demo app schema]: https://github.com/tcuwp/avocado/blob/main/spec/internal/db/schema.rb
