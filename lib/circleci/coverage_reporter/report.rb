module CircleCI
  module CoverageReporter
    class Report
      # @return [AbstractReporter]
      attr_reader :reporter

      # @return [AbstractResult]
      attr_reader :current_result

      # @return [AbstractResult, nil]
      attr_reader :base_result

      # @return [AbstractResult, nil]
      attr_reader :previous_result

      # @param reporter [AbstractReporter]
      # @param current [AbstractResult]
      # @param base [AbstractResult, nil]
      # @param previous [AbstractResult, nil]
      def initialize(reporter, current, base: nil, previous: nil)
        @reporter = reporter
        @current_result = current
        @base_result = base
        @previous_result = previous
      end

      # @return [String] coverage reporter name
      def type
        reporter.name
      end

      # @return [Float] coverage percent of the current build result
      def coverage
        current_result.coverage
      end

      # @return [String] URL for current coverage build result
      def url
        current_result.url
      end

      # @return [String, nil]
      def pretty_base_diff
        return unless base_diff
        pretty_diff(base_diff.round(2))
      end

      # @return [String, nil]
      def pretty_branch_diff
        return unless branch_diff
        pretty_diff(branch_diff.round(2))
      end

      # @return [Float, nil]
      def base_diff
        return unless base_result
        current_result.coverage - base_result.coverage
      end

      # @return [Float, nil]
      def branch_diff
        return unless previous_result
        current_result.coverage - previous_result.coverage
      end

      private

      # @param diff [Float]
      # @return [String]
      def pretty_diff(diff)
        if diff.nan?
          'NaN'
        elsif diff.positive?
          "+#{diff}"
        elsif diff.negative?
          diff.to_s
        else
          '±0'
        end
      end
    end
  end
end
