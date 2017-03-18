require_relative '../abstract_current_result'

module CircleCI
  module CoverageReporter
    module RubyCritic
      class CurrentResult < AbstractCurrentResult
        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          JSON.parse(File.read(join('report.json')))['score'].to_f
        end

        # @note Override {AbstractResult#pretty_coverage}
        # @return [String]
        def pretty_coverage
          "#{coverage.round(2)}pt"
        end

        private

        # @note Implementation for {AbstractCurrentResult#html_file_name}
        # @return [String]
        def html_file_name
          'overview.html'
        end
      end
    end
  end
end
