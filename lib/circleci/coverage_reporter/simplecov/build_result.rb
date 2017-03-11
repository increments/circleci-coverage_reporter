require_relative '../abstract_result'

module CircleCI
  module CoverageReporter
    module SimpleCov
      class BuildResult < AbstractResult
        # @param build [Build]
        def initialize(build)
          @build = build
        end

        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          JSON.parse(last_run.body)['result']['covered_percent']
        end

        private

        attr_reader :build

        # @return [Artifact]
        def last_run
          @last_run ||= build.artifacts.find { |a| a.end_with?('.last_run.json') }
        end
      end
    end
  end
end
