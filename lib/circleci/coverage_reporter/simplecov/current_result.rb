require_relative '../abstract_current_result'

module CircleCI
  module CoverageReporter
    module SimpleCov
      class CurrentResult < AbstractCurrentResult
        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          JSON.parse(File.read(join('.last_run.json')))['result']['covered_percent'].to_f
        end

        private

        # @note Implementation for {AbstractCurrentResult#html_file_name}
        # @return [String]
        def html_file_name
          'index.html'
        end
      end
    end
  end
end
