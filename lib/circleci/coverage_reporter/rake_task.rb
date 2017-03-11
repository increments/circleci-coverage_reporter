require 'circleci/coverage_reporter'

namespace :circleci do
  desc 'Report test coverage'
  task :report_coverage do
    abort unless ENV['CIRCLECI']

    CircleCI::CoverageReporter.configure do |config|
      config.circleci_token = ENV['COVERAGE_REPORTER_CIRCLECI_TOKEN']
      config.vcs_token = ENV['COVERAGE_REPORTER_VCS_TOKEN']
    end

    CircleCI::CoverageReporter.run
  end
end
