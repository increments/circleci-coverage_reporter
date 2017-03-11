require 'circleci/coverage_reporter/abstract_reporter'

RSpec.describe CircleCI::CoverageReporter::AbstractReporter do
  let(:reporter) do
    described_class.new
  end
end
