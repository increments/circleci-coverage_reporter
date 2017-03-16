require 'circleci/coverage_reporter/abstract_vcs_client'
require 'circleci/coverage_reporter/abstract_reporter'
require 'circleci/coverage_reporter/abstract_result'
require 'circleci/coverage_reporter/reports_renderer'
require 'circleci/coverage_reporter/report'

RSpec.describe CircleCI::CoverageReporter::ReportsRenderer do
  let(:reports_renderer) do
    described_class.new
  end

  describe '#render' do
    subject do
      reports_renderer.render(reports)
    end

    let(:reports) do
      [first_report, second_report]
    end

    let(:reporter_class) do
      Class.new(CircleCI::CoverageReporter::AbstractReporter) do
        def name
          'test'
        end
      end
    end

    let(:reporter) do
      reporter_class.new('test-path')
    end

    let(:result_class) do
      Class.new(CircleCI::CoverageReporter::AbstractResult) do
        # Implementation for {CircleCI::CoverageReporter::AbstractResult}
        attr_reader :coverage, :url

        def initialize(coverage, url)
          @coverage = coverage
          @url = url
        end
      end
    end

    let(:first_report) do
      CircleCI::CoverageReporter::Report.new(reporter, result_class.new(1, 'http://example.com/'))
    end

    let(:second_report) do
      CircleCI::CoverageReporter::Report.new(reporter, result_class.new(2, 'http://example.com/'))
    end

    it { should be_a String }

    context 'with custom template' do
      before do
        CircleCI::CoverageReporter.configure do |config|
          config.template = template
        end
      end

      let(:template) do
        <<-'ERB'
<%= vcs_type %>
<%- reports.each do |report| -%>
<%= report.current_result.coverage %>
<%- end -%>
        ERB
      end

      it { should eq "github\n1\n2\n" }
    end
  end
end
