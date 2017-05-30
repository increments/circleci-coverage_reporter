require 'ffaker'

require 'circleci/coverage_reporter/report'
require 'circleci/coverage_reporter/result'

module CircleCI::CoverageReporter
  ::RSpec.describe(Report) do
    let(:report) do
      described_class.new(reporter, current, base: base, previous: previous)
    end

    let(:reporter) do
      double('reporter', name: 'DummyReporter')
    end

    let(:current) do
      Result.new(rand, FFaker::Internet.http_url)
    end

    let(:base) do
      nil
    end

    let(:previous) do
      nil
    end

    describe '#to_s' do
      subject do
        report.to_s
      end

      it { should be_a String }

      context 'when base result is given' do
        let(:base) do
          Result.new(rand, FFaker::Internet.http_url)
        end

        it { should be_a String }
      end

      context 'when previous result is given' do
        let(:previous) do
          Result.new(rand, FFaker::Internet.http_url)
        end

        it { should be_a String }
      end

      context 'when both base and previous results are given' do
        let(:base) do
          Result.new(rand, FFaker::Internet.http_url)
        end

        let(:previous) do
          Result.new(rand, FFaker::Internet.http_url)
        end

        it { should be_a String }
      end
    end
  end
end
