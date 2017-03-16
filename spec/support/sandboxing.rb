require 'circleci/coverage_reporter/sandbox'

RSpec.configure do |c|
  c.around do |example|
    CircleCI::CoverageReporter::Sandbox.sandboxed do |_config|
      example.run
    end
  end
end
