require 'json'

require_relative '../result'
require_relative '../reporter'

module CircleCI
  module CoverageReporter
    module Reporters
      class SimpleCov < Reporter
        # @note Implement {Reporter#build_by_build_number}
        # @param build_number [Integer, nil]
        # @return [Result, nil]
        def build_by_build_number(build_number)
          return unless build_number
          artifact = CoverageReporter.client
                                     .artifacts(build_number)
                                     .find { |a| a.end_with?('.last_run.json') }
          build_by_json(artifact.body)
        end

        private

        # @return [Result]
        def build_by_json(json)
          Result.new(JSON.parse(json)['result']['covered_percent'])
        end
      end
    end
  end
end
