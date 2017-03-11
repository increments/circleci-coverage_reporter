module CircleCI
  module CoverageReporter
    class Report
      # @param current [AbstractResult]
      # @param base [AbstractResult, nil]
      # @param previous [AbstractResult, nil]
      def initialize(current:, base:, previous:)
        @current = current
        @base = base
        @previous = previous
      end
    end
  end
end
