# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [0.6.0] - 2017-05-30
### Changed
- Refactor how to implement reporter. Now a reporter consists of a single ruby class

### Removed
- Remove template configuration

## [0.5.0] - 2017-05-18
### Added
- Add Link reporter

## [0.4.0] - 2017-03-18
### Added
- Support [RubyCritic](https://github.com/whitesmith/rubycritic) score
- Enable to change score unit

### Changed
- Round coverage by default

### Fixed
- Make sure that `#coverage` methods return a `Float` object

## [0.3.1] - 2017-03-17
### Fixed
- Suppress emoji if base diff is NaN or zero

## [0.3.0] - 2017-03-16
### Added
- Add template configuration

### Changed
- Remove `CircleCI::CoverageReporter::Client#configuration`

### Fixed
- Run each example in sandbox

## [0.2.0] - 2017-03-14
### Added
- Support [Flow](https://flowtype.org) coverage reported by [flow-coverage-report](https://github.com/rpl/flow-coverage-report)

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

[Unreleased]: https://github.com/increments/circleci-coverage_reporter/compare/v0.6.0...HEAD
[0.6.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/increments/circleci-coverage_reporter/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/increments/circleci-coverage_reporter/compare/v0.1.0...v0.1.1
