# CircleCI::CoverageReporter

[![Gem](https://img.shields.io/gem/v/circleci-coverage_reporter.svg)](https://rubygems.org/gems/circleci-coverage_reporter)
[![CircleCI](https://img.shields.io/circleci/project/github/increments/circleci-coverage_reporter.svg)](https://circleci.com/gh/increments/circleci-coverage_reporter)
[![Gemnasium](https://img.shields.io/gemnasium/increments/circleci-coverage_reporter.svg)](https://gemnasium.com/github.com/increments/circleci-coverage_reporter)
[![Code Climate](https://img.shields.io/codeclimate/github/increments/circleci-coverage_reporter.svg)](https://codeclimate.com/github/increments/circleci-coverage_reporter)

**CircleCI::CoverageReporter** reports test coverage to your GitHub repository.

## Example

![image](https://cloud.githubusercontent.com/assets/96157/23824715/e16f0eac-06be-11e7-81e8-f818b14a52b4.png)

## Getting started

1.  Add CircleCI::CoverageReporter to your `Gemfile` and `bundle install`:

    ```ruby
    gem 'circleci-coverage_reporter', group: :test
    ```

2.  Load `circleci/coverage_reporter/rake_task` in your `Rakefile`:

    ```ruby
    require 'circleci/coverage_reporter/rake_task' if ENV['CIRCLECI']
    ```

3.  Issue CircleCI and GitHub tokens and add them to build environment variables as follows:

    Name                               | Value
    -----------------------------------|----------------------------------------------------------------
    `COVERAGE_REPORTER_CIRCLECI_TOKEN` | CircleCI API token with "view-builds" scope
    `COVERAGE_REPORTER_VCS_TOKEN`      | GitHub personal access token with "repo" or "public_repo" scope

4.  Add the following step to your `circle.yml`:

    ```yaml
    test:
      post:
      - bundle exec rake circleci:report_coverage
    ```

## Run manually

You must configure `circleci_token` and `vcr_token` before `CircleCI::CoverageReporter.run`:

```ruby
CircleCI::CoverageReporter.configure do |config|
  config.circleci_token = YOUR_CIRCLECI_API_TOKEN
  config.vcr_token = YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
end

CircleCI::CoverageReporter.run
```

## Reporters
### SimpleCov

`CircleCI::CoverageReporter::Reporters::SimpleCovReporter` handles coverage files generated by
[SimpleCov](https://github.com/colszowka/simplecov).

It expects that coverage files are located in `$CIRCLE_ARTIFACTS/coverage` directory:

```ruby
# spec/spec_helper.rb
require 'simplecov'
# Save to CircleCI's artifacts directory if we're on CircleCI
SimpleCov.coverage_dir(File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')) if ENV['CIRCLECI']
SimpleCov.start
```

If you put files in another directory, say `$CIRCLE_ARTIFACTS/foo/bar`, you have to set reporter as follows:

```ruby
CircleCI::CoverageReporter.configure do |config|
  config.reporters << CircleCI::CoverageReporter::Reporters::SimpleCov.new(dir: 'foo/bar')
end
```

### Flow

`CircleCI::CoverageReporter::Reporters::FlowReporter` handles coverage files generated by
[flow-coverage-report](https://github.com/rpl/flow-coverage-report)

It expects that there is `$CIRCLE_ARTIFACTS/flow-coverage/flow-coverage.json`:

```bash
$(npm bin)/flow-coverage-report -t json -o $CIRCLE_ARTIFACTS/flow-coverage
```

If you put the file in another path, say `$CIRCLE_ARTIFACTS/foo/bar/flow-coverage.json`,
you have to set reporter as follows:

```ruby
CircleCI::CoverageReporter.configure do |config|
  config.reporters << CircleCI::CoverageReporter::Reporters::Flow.new(dir: 'foo/bar')
end
```

### RubyCritic

`CircleCI::CoverageReporter::Reporters::RubyCritic` handles code quality files generated by
[rubycritic](https://github.com/whitesmith/rubycritic)

```bash
bundle exec rubycritic -p $CIRCLE_ARTIFACTS/rubycritic -f json --no-browser --mode-ci app
bundle exec rubycritic -p $CIRCLE_ARTIFACTS/rubycritic -f html --no-browser --mode-ci app
```

### Link

`CircleCI::CoverageReporter::Reporters::Link` reports a link to an artifact file.

```ruby
CircleCI::CoverageReporter.configure do |config|
  config.reporters << CircleCI::CoverateReporter::Reporters::Link.new(path: 'path/to/file', name: 'NAME')
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
