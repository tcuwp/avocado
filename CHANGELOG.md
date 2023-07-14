## [Unreleased]

- Validate presence, uniqueness, and format on `email` attribute
- Normalize email value during save
- Validate password format and length
- Include a token generator for password recovery

## [0.1.0] - 2023-07-14

- Initial release
- Add `Avocado::UserConcern` which calls `has_secure_password`
