module CircleCI
  module CoverageReporter
    class Report
      # @param current [Result]
      # @param base [Result, nil]
      # @param previous [Result, nil]
      def initialize(current:, base:, previous:)
        @current = current
        @base = base
        @previous = previous
      end
    end
  end
end
