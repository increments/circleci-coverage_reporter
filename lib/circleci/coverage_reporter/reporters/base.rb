require_relative '../report'

module CircleCI
  module CoverageReporter
    module Reporters
      # @abstract Subclass and override {.default_dir}, {.default_html_file_name},
      #   {.default_json_file_name} and {#parse_json} to implement a custom Reporter class.
      class Base
        def self.default_dir
          raise NotImplementedError
        end

        def self.default_html_file_name
          raise NotImplementedError
        end

        def self.default_json_file_name
          raise NotImplementedError
        end

        def initialize(options = {})
          @options = options
        end

        # @return [Boolean]
        def active?
          File.directory?(File.join(configuration.artifacts_dir, dir))
        end

        # @param base_build [Build, nil]
        # @param previous_build [Build, nil]
        # @return [Report]
        def report(base_build, previous_build)
          Report.new(
            self,
            create_current_result,
            base: base_build ? create_build_result(base_build) : nil,
            previous: previous_build ? create_build_result(previous_build) : nil
          )
        end

        # Name of reporter.
        #
        # @return [String]
        def name
          self.class.name.split('::').last
        end

        private

        # @return [String]
        def dir
          @options[:dir] || self.class.default_dir
        end

        def html_file_name
          @options[:html_file_name] || self.class.default_html_file_name
        end

        def json_file_name
          @options[:json_file_name] || self.class.default_json_file_name
        end

        # @param build [Build, nil]
        # @return [Result, nil]
        def create_build_result(build)
          Result.new(build_coverage(build), build_url(build))
        end

        # @return [AbstractResult]
        def create_current_result
          Result.new(current_coverage, current_url)
        end

        # @return [Float]
        def current_coverage
          parse_json(File.read(File.join(configuration.artifacts_dir, dir, json_file_name)))
        end

        # @return [String]
        def current_url
          [
            'https://circle-artifacts.com/gh',
            configuration.project,
            configuration.current_build_number,
            'artifacts',
            "0#{configuration.artifacts_dir}",
            dir,
            html_file_name
          ].join('/')
        end

        # @param build [Build]
        # @return [Float]
        def build_coverage(build)
          artifact = build.find_artifact(json_file_name) or return Float::NAN
          parse_json(artifact.body)
        end

        # @param build [Build]
        # @return [String]
        def build_url(build)
          artifact = build.find_artifact(html_file_name) or return '#'
          artifact.url
        end

        def configuration
          CoverageReporter.configuration
        end

        # @param json [String]
        # @return [Float]
        def parse_json(json) # rubocop:disable Lint/UnusedMethodArgument
          raise NotImplementedError
        end
      end
    end
  end
end
