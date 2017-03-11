require 'json'

require_relative '../result'
require_relative '../reporter'

module CircleCI
  module CoverageReporter
    module Reporters
      class SimpleCov < Reporter
        DEFAULT_PATH = File.join('coverage', '.last_run.json')

        # @param path [String] relative path from artifacts dir to .last_run.json
        def initialize(path = nil)
          @path = File.join(client.configuration.artifacts_dir, path || DEFAULT_PATH)
        end

        # @note Implement {Reporter#build_by_build_number}
        # @param build_number [Integer, nil]
        # @return [Result, nil]
        def build_by_build_number(build_number)
          return unless build_number
          artifact = client.artifacts(build_number).find { |a| a.end_with?('.last_run.json') }
          build_by_json(artifact.body)
        end

        # @note Implement {Reporter#build_by_current_artifact}
        def build_by_current_artifact
          build_by_json(File.read(path))
        end

        private

        # @return [String] absolute path to .last_run.json
        attr_reader :path

        # @return [Result]
        def build_by_json(json)
          Result.new(JSON.parse(json)['result']['covered_percent'])
        end
      end
    end
  end
end
