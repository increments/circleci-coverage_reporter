# CircleCI::CoverageReporter

[![CircleCI](https://circleci.com/gh/increments/circleci-coverage_reporter.svg?style=svg)](https://circleci.com/gh/increments/circleci-coverage_reporter)

**CircleCI::CoverageReporter** reports test coverage to your GitHub repository.

## Getting started

1.  Add CircleCI::CoverageReporter to your `Gemfile` and `bundle install`:

    ```ruby
    gem 'circleci-coverage_reporter', group: :test
    ```

2.  Load `circleci/coverage_reporter/rake_task` in your `Rakefile`:

    ```ruby
    require 'circleci/coverage_reporter/rake_task' if ENV['CIRCLECI']
    ```

3.  Issue CircleCI and GitHub token and add them to build environment variables with the following nameing convention:

    Name                               | Value
    -----------------------------------|----------------------------------------------------------------
    `COVERAGE_REPORTER_CIRCLECI_TOKEN` | CircleCI API token with "view-builds" scope
    `COVERAGE_REPORTER_VCS_TOKEN`      | GitHub personal access token with "repo" or "public_repo" scope

4.  Add the following steop to your `circle.yml`:

    ```yaml
    test:
      post:
      - bundle exec circleci:report_coverage
    ```

## Example

![image](https://cloud.githubusercontent.com/assets/96157/23824715/e16f0eac-06be-11e7-81e8-f818b14a52b4.png)

## Configuring CircleCI::CoverageReporter

```ruby
CircleCI::CoverageReporter.configure do |config|
  config.circleci_token = YOUR_CIRCLECI_API_TOKEN
  config.vcr_token = YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
end
```

then:

```ruby
CircleCI::CoverageReporter.run
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
