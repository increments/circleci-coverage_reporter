# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.2.0] - 2017-03-14
### Added
- Support [Flow](flowtype.org) coverage reported by [flow-coverage-report](https://github.com/rpl/flow-coverage-report)

### Fixed
- Disable inactive reporters
- Fix uninitialized constant `Float::NaN`

## [0.1.3] - 2017-03-12
### Fixed
- Raise `RequestError` if some API reqeust fails
- Show `NaN` if .last_run.json does not exist

## [0.1.2] - 2017-03-12
### Fixed

- Set `nil` to previous_build_number if CIRCLE_PREVIOUS_BUILD_NUM environment variable is empty

## [0.1.1] - 2017-03-12
### Fixed

- Ignore base_build if it is on master branch

## 0.1.0 - 2017-03-12
### Added

- Initial release

[Unreleased]: https://github.com/increments/circleci-coverage_reporter/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.0...v0.1.1
