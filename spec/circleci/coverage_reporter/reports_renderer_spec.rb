require 'circleci/coverage_reporter/reporters/base'
require 'circleci/coverage_reporter/reports_renderer'
require 'circleci/coverage_reporter/report'
require 'circleci/coverage_reporter/result'

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
      Class.new(CircleCI::CoverageReporter::Reporters::Base) do
        def name
          'test'
        end
      end
    end

    let(:reporter) do
      reporter_class.new('test-path')
    end

    let(:first_report) do
      CircleCI::CoverageReporter::Report.new(reporter, CircleCI::CoverageReporter::Result.new(1, 'http://example.com/'))
    end

    let(:second_report) do
      CircleCI::CoverageReporter::Report.new(reporter, CircleCI::CoverageReporter::Result.new(2, 'http://example.com/'))
    end

    it { should be_a String }

    context 'with custom template' do
      before do
        CircleCI::CoverageReporter.configure do |config|
          config.template = template
        end
      end

      let(:template) do
        <<~'ERB'
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
