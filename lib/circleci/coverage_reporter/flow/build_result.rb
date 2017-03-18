require_relative '../abstract_build_result'

module CircleCI
  module CoverageReporter
    module Flow
      class BuildResult < AbstractBuildResult
        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          flow_coverage_json = find_artifact('flow-coverage.json') or return Float::NAN
          JSON.parse(flow_coverage_json.body)['percent'].to_f
        end

        # @note Implement {AbstractResult#url}
        # @return [String]
        def url
          index_html = find_artifact('index.html') or return '#'
          index_html.url
        end
      end
    end
  end
end
