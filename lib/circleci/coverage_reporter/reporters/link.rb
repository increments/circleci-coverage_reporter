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

        def initialize(options = {})
          @options = options
        end

        # @note Implementation for {Base#active?}
        def active?
          File.file?(File.join(configuration.artifacts_dir, @options[:path]))
        end

        # @note Override {Base#name}
        def name
          @options[:name]
        end

        def report(_base_build, _previous_build)
          LinkReport.new(@options[:name], url)
        end

        private

        # @return [String]
        def url
          [
            'https://circle-artifacts.com/gh',
            configuration.project,
            configuration.current_build_number,
            'artifacts',
            "0#{configuration.artifacts_dir}",
            @options[:path]
          ].join('/')
        end

        def configuration
          CoverageReporter.configuration
        end
      end
    end
  end
end
