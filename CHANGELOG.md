# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2021-12-25
### Fixed
- Outdated project template.
- Inconsistent extra lines when error occurs.
### Removed
- `build` and `serve` command. Very hard to maintain & build a global package
  that uses null-safety itself but contains some unsound-null-safety code.

## [1.0.2] - 2021-06-14
### Fixed
- Fix missing `.gitignore` file (isn't generated when creating).
### Added
- Run `pub get` after creating a new project.
### Removed
- Remoed unnecessary models, though this doesn't affect the program at all

## [1.0.1] - 2021-05-31
### Fixed
- Duplicate usage message on `UsageException`.
- Symbols in debug logs can't show on some devices due to the use of illegal characters.

## [1.0.0] - 2021-05-30
### Added
- Initial version.
