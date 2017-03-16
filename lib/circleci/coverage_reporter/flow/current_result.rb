require_relative '../abstract_result'

module CircleCI
  module CoverageReporter
    module Flow
      class CurrentResult < AbstractResult
        # @param path [String] path to coverage directory
        def initialize(path)
          @path = path
        end

        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          JSON.parse(File.read(join('flow-coverage.json')))['percent']
        end

        # @note Implement {AbstractResult#url}
        # @return [String]
        def url
          [
            'https://circle-artifacts.com/gh',
            configuration.project,
            configuration.current_build_number,
            'artifacts',
            "0#{configuration.artifacts_dir}",
            path,
            'index.html'
          ].join('/')
        end

        private

        attr_reader :path

        # @return
        def join(name)
          File.join(configuration.artifacts_dir, path, name)
        end

        # @return [Configuration]
        def configuration
          CoverageReporter.configuration
        end
      end
    end
  end
end
