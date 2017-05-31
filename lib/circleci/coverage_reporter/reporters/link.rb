require_relative '../result'

module CircleCI
  module CoverageReporter
    module Reporters
      class Link
        LinkReport = Struct.new(:name, :url) do
          def to_s
            "[#{name}](#{url})"
          end
        end

        # @param path [String]
        # @param name [String]
        def initialize(path:, name:)
          @path = path
          @name = name
        end

        # @note Implementation for {Base#active?}
        def active?
          File.file?(File.join(configuration.artifacts_dir, path))
        end

        # @note Override {Base#name}
        attr_reader :name

        def report(_base_build, _previous_build)
          LinkReport.new(name, url)
        end

        private

        attr_reader :path

        # @return [String]
        def url
          [
            'https://circle-artifacts.com/gh',
            configuration.project,
            configuration.current_build_number,
            'artifacts',
            "0#{configuration.artifacts_dir}",
            path
          ].join('/')
        end

        def configuration
          CoverageReporter.configuration
        end
      end
    end
  end
end
