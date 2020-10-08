module CircleCI
  module CoverageReporter
    # Encapsulate a report created by a reporter.
    #
    # @see Reporters::Base#report
    class Report
      # @param reporter [Reporters::Base] the reporter of the report
      # @param current [Result]
      # @param base [Result, nil] result at master branch
      # @param previous [Result, nil] result at previous build in same branch
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

      # @return [String]
      def link
        "[#{reporter.name}](#{current_result.url})"
      end

      # @return [String]
      def emoji
        if base_diff.nil? || base_diff.nan? || base_diff.round(2).zero?
          ''
        elsif base_diff.positive?
          ':chart_with_upwards_trend:'
        else
          ':chart_with_downwards_trend:'
        end
      end

      # @return [String]
      def progress
        progresses.empty? ? '' : "(#{progresses.join(', ')})"
      end

      # @return [Array<String>]
      def progresses
        [base_progress, branch_progress].compact
      end

      # @return [String, nil]
      def base_progress
        base_diff ? "[master](#{base_result.url}): #{pretty_base_diff}" : nil
      end

      # @return [String, nil]
      def branch_progress
        branch_diff ? "[previous](#{previous_result.url}): #{pretty_branch_diff}" : nil
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
