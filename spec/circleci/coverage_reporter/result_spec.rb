require 'ffaker'

require 'circleci/coverage_reporter/result'

module CircleCI::CoverageReporter
  ::RSpec.describe(Result) do
    let(:result) do
      described_class.new(coverage, url)
    end

    let(:coverage) do
      rand
    end

    let(:url) do
      FFaker::Internet.http_url
    end

    %w[coverage url].each do |attr_name|
      describe "##{attr_name}" do
        subject do
          result.public_send(attr_name)
        end

        it 'returns the corresponding constructor parameter' do
          should eq public_send(attr_name)
        end
      end
    end

    describe '#pretty_coverage' do
      subject do
        result.pretty_coverage
      end

      it { should be_a String }
    end
  end
end
