require_relative '../abstract_result'

module CircleCI
  module CoverageReporter
    module SimpleCov
      class CurrentResult < AbstractResult
        # @param path [String] path to coverage directory
        def initialize(path)
          @path = path
        end

        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          JSON.parse(File.read(join('.last_run.json')))['result']['covered_percent']
        end

        private

        attr_reader :path

        # @return
        def join(name)
          File.join(client.configuration.artifacts_dir, path, name)
        end

        # @return [Client]
        def client
          CoverageReporter.client
        end
      end
    end
  end
end
