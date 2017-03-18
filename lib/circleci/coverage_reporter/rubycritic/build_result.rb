require_relative '../abstract_build_result'

module CircleCI
  module CoverageReporter
    module RubyCritic
      class BuildResult < AbstractBuildResult
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
      end
    end
  end
end
