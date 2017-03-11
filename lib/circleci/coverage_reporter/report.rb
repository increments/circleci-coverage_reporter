module CircleCI
  module CoverageReporter
    class Report
      # @param reporter [AbstractReporter]
      # @param current [AbstractResult]
      # @param base [AbstractResult, nil]
      # @param previous [AbstractResult, nil]
      def initialize(reporter, current:, base:, previous:)
        @reporter = reporter
        @current = current
        @base = base
        @previous = previous
      end
    end
  end
end
