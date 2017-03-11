require 'circleci/coverage_reporter'

namespace :circleci do
  desc 'Report test coverage'
  task :report_coverage do
    abort unless ENV['CIRCLECI']

    CircleCI::CoverageReporter.configure do |config|
      config.circleci_token = ENV['COVERAGE_REPORTER_CIRCLECI_TOKEN']
      config.vcs_token = ENV['COVERAGE_REPORTER_VCS_TOKEN']

      config.artifacts_dir = ENV['CIRCLE_ARTIFACTS']
      config.base_revision = `git merge-base origin/master HEAD`.strip
      config.current_revision = ENV['CIRCLE_SHA1']
      config.previous_build_number = ENV['CIRCLE_PREVIOUS_BUILD_NUM'].to_i
      config.repository_name = ENV['CIRCLE_PROJECT_REPONAME']
      config.user_name = ENV['CIRCLE_PROJECT_USERNAME']
    end

    CircleCI::CoverageReporter.run
  end
end
