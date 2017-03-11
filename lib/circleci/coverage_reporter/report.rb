module CircleCI
  module CoverageReporter
    class Report
      # @param reporter [AbstractReporter]
      # @param current [AbstractResult]
      # @param base [AbstractResult, nil]
      # @param previous [AbstractResult, nil]
      def initialize(reporter, current:, base:, previous:)
        @reporter = reporter
        @current_result = current
        @base_result = base
        @previous_result = previous
      end

      # @return [String]
      def to_s
        "#{link}: #{current_result.coverage}%#{emoji}#{progress}"
      end

      private

      attr_reader :reporter, :current_result, :base_result, :previous_result

      # @return [String]
      def link
        "[#{reporter.name}](#{current_result.url})"
      end

      # @return [String, nil]
      def emoji
        return unless base_result
        if current_result.coverage < base_result.coverage
          ' :chart_with_downwards_trend:'
        elsif current_result.coverage > base_result.coverage
          ' :chart_with_upwards_trend:'
        end
      end

      # @return [String, nil]
      def progress
        elements = [base_progress, branch_progress].compact
        elements.empty? ? nil : " (#{elements.join(', ')})"
      end

      # @return [String, nil]
      def base_progress
        return unless base_result
        "[master](#{base_result.url}): #{diff(current_result, base_result)}"
      end

      # @return [String, nil]
      def branch_progress
        return unless previous_result
        "[previous](#{previous_result.url}): #{diff(current_result, previous_result)}"
      end

      # @param after_result [AbstractResult]
      # @param before_result [AbstractResult]
      # @return [String]
      def diff(after_result, before_result)
        value = (after_result.coverage - before_result.coverage).round(2)
        if value.nan?
          'NaN'
        elsif value.positive?
          "+#{value}"
        elsif value.negative?
          value.to_s
        else
          '±0'
        end
      end
    end
  end
end
