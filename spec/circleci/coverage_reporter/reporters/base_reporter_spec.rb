require 'circleci/coverage_reporter/reporters/base_reporter'

RSpec.describe CircleCI::CoverageReporter::Reporters::BaseReporter do
  let(:reporter) do
    described_class.new
  end

  describe '#build_by_build_number' do
    subject do
      reporter.build_by_build_number(1)
    end

    it { expect { subject }.to raise_error(NotImplementedError) }
  end
end
