## [Unreleased]

- Add an `Avocado::Mailer` which generates each of the signed ids

## [0.2.0] - 2023-07-15

- Validate presence, uniqueness, and format on `email` attribute
- Normalize email value during save
- Validate password format and length
- Include a token generator for password recovery
- Rename `Avocado::UserConcern` to `Avocado::User`

## [0.1.0] - 2023-07-14

- Initial release
- Add `Avocado::UserConcern` which calls `has_secure_password`
