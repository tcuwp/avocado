## [Unreleased]

## [0.6.0] - 2023-07-25

- Change affirmations and verifications to require user action
- Use session token instead of id for signed cookie value
- Add migration generators

## [0.5.0] - 2023-07-21

- Add controller for "passwordless" email-link sign-in
- Add event class to log user auth events
- Add user-facing email and password edit pages
- Add various event logging callbacks
- Sign out all non current sessions when password changes

## [0.4.0] - 2023-07-19

- Convert the `Avocado::Mailer` module into a class
- Add controllers for signing up, signing in, password reset and email
  verification

## [0.3.0] - 2023-07-17

- Add an `Avocado::Mailer` which generates each of the signed ids
- Rename `password_recovery` to `password_reset`

## [0.2.0] - 2023-07-15

- Validate presence, uniqueness, and format on `email` attribute
- Normalize email value during save
- Validate password format and length
- Include a token generator for password recovery
- Rename `Avocado::UserConcern` to `Avocado::User`

## [0.1.0] - 2023-07-14

- Initial release
- Add `Avocado::UserConcern` which calls `has_secure_password`
