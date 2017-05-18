require_relative 'abstract_result'

module CircleCI
  module CoverageReporter
    class AbstractCurrentResult < AbstractResult
      # @param path [String] path to coverage directory
      def initialize(path)
        @path = path
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
          html_file_name
        ].compact.join('/')
      end

      private

      attr_reader :path

      # @return [String]
      def html_file_name
        raise NotImplementedError
      end

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
