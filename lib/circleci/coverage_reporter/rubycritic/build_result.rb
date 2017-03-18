require_relative '../abstract_result'

module CircleCI
  module CoverageReporter
    module RubyCritic
      class BuildResult < AbstractResult
        # @param path [String]
        # @param build [Build]
        def initialize(path, build)
          @path = path
          @build = build
        end

        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          last_run_json = find_artifact('report.json') or return Float::NAN
          JSON.parse(last_run_json.body)['score'].to_f
        end

        # @note Implement {AbstractResult#url}
        # @return [String]
        def url
          index_html = find_artifact('overview.html') or return '#'
          index_html.url
        end

        private

        attr_reader :build, :path

        # @param end_with [String]
        # @return [Artifact]
        def find_artifact(end_with)
          build.artifacts.find { |a| a.end_with?("#{path}/#{end_with}") }
        end
      end
    end
  end
end
