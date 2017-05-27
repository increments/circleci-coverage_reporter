module CircleCI
  module CoverageReporter
    class Report
      # @param reporter [Reporters::Base]
      # @param current [Result]
      # @param base [Result, nil]
      # @param previous [Result, nil]
      def initialize(reporter, current, base: nil, previous: nil)
        @reporter = reporter
        @current_result = current
        @base_result = base
        @previous_result = previous
      end

      # @return [String]
      def to_s
        "#{link}: #{current_result.pretty_coverage}#{emoji}#{progress}"
      end

      private

      attr_reader :reporter, :current_result, :base_result, :previous_result

      def link
        "[#{reporter.name}](#{current_result.url})"
      end

      def emoji
        if base_diff.nil? || base_diff.nan? || base_diff.round(2).zero?
          nil
        elsif base_diff.positive?
          ':chart_with_upwards_trend:'
        else
          ':chart_with_downwards_trend:'
        end
      end

      def progress
        progresses.empty? ? nil : "(#{progresses.join(', ')})"
      end

      def progresses
        [base_progress, branch_progress].compact
      end

      def base_progress
        base_diff ? "[master](#{base_result.url}): #{pretty_base_diff}" : nil
      end

      def branch_progress
        branch_diff ? "[previous](#{previous_result.url}): #{pretty_branch_diff}" : nil
      end

      # @return [String]
      def pretty_coverage
        current_result.pretty_coverage
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
