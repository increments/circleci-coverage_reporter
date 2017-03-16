require 'erb'

module CircleCI
  module CoverageReporter
    class ReportsRenderer
      # @param reports [Array<Report>]
      # @return [String]
      def render(reports)
        ERB.new(
          CoverageReporter.configuration.template,
          nil,
          CoverageReporter.configuration.template_trim_mode
        ).result(binding)
      end

      private

      # @return [String]
      def vcs_type
        CoverageReporter.configuration.vcs_type
      end
    end
  end
end
