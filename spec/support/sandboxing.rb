require 'circleci/coverage_reporter/sandbox'
require 'tmpdir'

RSpec.configure do |c|
  c.around do |example|
    original_env = ENV.to_h
    CircleCI::CoverageReporter::Sandbox.sandboxed do |_config|
      Dir.mktmpdir do |dir|
        ENV['CIRCLE_ARTIFACTS'] = dir
        example.run
      end
    end
    ENV.replace(original_env)
  end
end
