require_relative '../result'

module CircleCI
  module CoverageReporter
    module Reporters
      class Link
        # @attr name [String]
        # @attr url [String]
        # @attr base_url [String, nil]
        # @attr previous_url [String, nil]
        LinkReport = Struct.new(:name, :url, :base_url, :previous_url) do
          # @return [String]
          def to_s
            links = []
            links << "[master](#{base_url})" if base_url
            links << "[previous](#{previous_url})" if previous_url
            link = links.empty? ? nil : " (#{links.join(', ')})"
            "[#{name}](#{url})#{link}"
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

        # @param base_build [Build, nil]
        # @param previous_build [Build, nil]
        # @return [LinkReport]
        def report(base_build, previous_build)
          LinkReport.new(name, url, extract_artifact_url(base_build), extract_artifact_url(previous_build))
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

        # @param build [Build, nil]
        # @return [String, nil]
        def extract_artifact_url(build)
          return unless build
          artifact = build.find_artifact(path)
          artifact ? artifact.url : nil
        end
      end
    end
  end
end
