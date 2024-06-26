# Overview

The 🥑 gem is a [Rails Engine] composed of a mixture of Ruby modules that get
included into application classes and Ruby classes which will run directly from
the 🥑 gem itself. The classes are intended to provide good defaults for basic
scenarios, and can be subclassed and overridden for special cases.

## Requirements

Apps must be running Rails 7.1 or newer. The 🥑 gem uses features like
`authenticate_by`, the `password_challenge` feature of `has_secure_password`,
`generates_token_for`, and `normalizes` which don't exist in earlier versions.

The database schema must have columns that match the `users`, `sessions`, and
`events` tables from the [demo app schema]. More columns in each table are
acceptable; the demo is just a minimum. Slight variations (using `uuid` instead
of `bigint` for example) are harmless, but large departures will break the
integration.

Run `bin/rails g avocado:migrations` to generate migrations for the tables.

The application must also have:

- An `ApplicationController` base controller class for the controllers to
  inherit from.
- An `ApplicationMailer` base mailer class which sets a layout and default
  `from` value.
- A `root_path` route helper method (typically generated by routes configured in
  the application).

## Usage

### Models

Include these modules into `ActiveRecord` model classes:

```ruby
class User < ApplicationRecord
  include Avocado::User
end

class Session < ApplicationRecord
  include Avocado::Session
end

class Event < ApplicationRecord
  include Avocado::Event
end
```

This will set up some basic associations, validations, callbacks, and
normalizations for those models.

### Controllers

Add the `Avocado::Authentication` module to the top-level controller:

```ruby
class ApplicationController < ActionController::Base
  include Avocado::Authentication
end
```

### Routes

By defalt, 🥑 does not add any routes to the application when initialized. To
hook up the controllers to routes, they must be added to the `config/routes.rb`
of the application. It's possible to add all of the routes, or just a subset.

This example defines a `root` route and also pulls in every feature route:

```ruby
Rails.application.routes.draw do
  root to: "records#index"
  draw(🥑)
end
```

This example defines a `root` route and adds only a subset of feature routes:

```ruby
Rails.application.routes.draw do
  root to: "records#index"
  scope module: 🥑 do
    resources :registrations, only: %i[new create]
    resources :sessions, only: %i[new create destroy]
  end
end
```

## Summary

### Routable controller features

The 🥑 gem will create REST-ful routes that go to the various controllers during
app initialization.

These external (unauthenticated) features are available:

- `Registrations` -- Fill out new user form and create users
- `Sessions` -- Sign in and sign out
- `Recoveries` -- Triggers password reset via emailed expiring link
- `Credentials` -- Use expiring token link from recovery to update password
- `Verifications` -- Confirm email address on account creation or email change
- `Affirmations` -- "Passwordless" authentication via emailed expiring link

These internal (authenticated) features are available:

- `Sessions` -- Index view of active sessions, ability to destroy sessions
- `Events` -- Index view of the user activity audit log
- `Passwords` -- Edit and update a user password
- `Emails` -- Edit and update a user email

Linking to any of these internal pages is optional. Apps can use them as-is,
override their views, or even ignore them entirely and make local versions.

### Mailers

There is an `Avocado::Mailer` which gets called to send emails. The mailer views
here are very basic, and should be overriden within applications. Place views
within `app/views/avocado/mailer/` to make this happen.

### Filters

There are two methods added to the default `before_action` stack:

- The `authenticate` method defaults controller behavior to require a signed in
  session. Actions can disable it with `skip_before_action :authenticate`, or
  inherit from a controller which performs the skip.
- The `set_current_request_details` method makes some loggable request meta
  information (User Agent, IP Address) values available in `Current` so that
  they are accesible to code elsewhere in the 🥑 gem.

### Helpers

The `Avocado::Authentication` module included into the application controller
provides some helper methods available in controllers, views, and helpers:

- `signed_in?` is true if the session has a signed in user
- `current_session` provides the DB record for the session, if one exists
- `current_user` returns the user belonging to that session

Usage of these can be seen in the views in the [demo app].

## Customization

There is not any configuration. To override functionality:

- Redefine a method created in one of the models by the included module
- Subclass a controller and update the routing to go to the subclass
- Place views in the app where 🥑 expects them (`app/views/avocado`) to override

There is an `avocado:views` generator which will copy all the views as a
starting point for further modification.

## Examples

There is a [demo app] used by the specs which has some example usage.

[demo app schema]: https://github.com/tcuwp/avocado/blob/main/spec/internal/db/schema.rb
[demo app]: https://github.com/tcuwp/avocado/blob/main/spec/internal
[Rails Engine]: https://guides.rubyonrails.org/engines.html#what-are-engines-questionmark
