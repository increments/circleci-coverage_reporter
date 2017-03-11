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
          JSON.parse(find_artifact('.last_run.json').body)['result']['covered_percent']
        end

        # @note Implement {AbstractResult#url}
        # @return [String]
        def url
          find_artifact('index.html').url
        end

        private

        attr_reader :build

        # @param end_with [String]
        # @return [Artifact]
        def find_artifact(end_with)
          build.artifacts.find { |a| a.end_with?(end_with) }
        end
      end
    end
  end
end
