require 'circleci/coverage_reporter'

RSpec.describe CircleCI::CoverageReporter do
  describe '.configuration' do
    subject do
      described_class.configuration
    end

    it { should be_a described_class::Configuration }
  end

  describe '.client' do
    subject do
      described_class.client
    end

    it { should be_a described_class::Client }
  end

  describe '.configure' do
    it 'yields with CircleCI::CoverageReporter::Configuration' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(a_kind_of(described_class::Configuration))
    end
  end
end
