# Changelog

## [0.8.0] - 2024-10-22

### Changed

- Minimum ruby version is now 3.2
- Allow Rails versions 7.2 and 8.0

## [0.7.0] - 2023-08-10

### Added

- An `avocado:views` generator copies engine views into application

### Changed

- Flash messages for controllers moved to i18n yml
- View forms updated to use `_form` partials
- Move the reset phase of password recovery to a `Credentials` controller

## [0.6.0] - 2023-07-25

### Added

- Migration generator

### Changed

- Affirmation and Verification paths require user action
- Use session `token` instead of `id` for signed cookie value

## [0.5.0] - 2023-07-21

### Added

- Controller for "passwordless" email-link sign-in
- `Event` class to log user auth events
- User-facing email and password edit pages
- Misc event logging callbacks

### Changed

- Sign out all non-current sessions when password changes

## [0.4.0] - 2023-07-19

### Added

- Controllers for signing up, signing in, password reset and email verification

### Changed

- Convert the `Avocado::Mailer` module into a class

## [0.3.0] - 2023-07-17

### Added

- `Avocado::Mailer` which generates each of the signed ids

### Changed

- Rename `password_recovery` to `password_reset`

## [0.2.0] - 2023-07-15

### Added

- Validations for presence, uniqueness, and format on `email` attribute
- Normalizer for email value during save
- Validations on password format and length
- Token generator for password recovery

### Changed

- Rename `Avocado::UserConcern` to `Avocado::User`

## [0.1.0] - 2023-07-14

### Added

- `Avocado::UserConcern` which calls `has_secure_password`
