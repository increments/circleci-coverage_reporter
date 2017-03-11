require 'faraday'

require_relative 'artifact'
require_relative 'build'

module CircleCI
  module CoverageReporter
    class Client
      CIRCLECI_ENDPOINT = 'https://circleci.com/api/v1.1'.freeze

      # @return [Configuration]
      attr_reader :configuration

      # @param configuration [Configuration]
      def initialize(configuration)
        @configuration = configuration
      end

      # @param build_number [Integer]
      # @return [Array<Artifact>]
      def artifacts(build_number)
        JSON.parse(get(artifacts_url(build_number)).body).map do |hash|
          Artifact.new(hash['path'], hash['pretty_path'], hash['node_index'], hash['url'])
        end
      end

      # @param revision [String]
      # @param branch [String, nil]
      # @return [Integer, nil]
      def build_number_by_revision(revision, branch: nil)
        build = recent_builds(branch).find { |b| b.match?(revision) }
        build ? build.build_num : nil
      end

      # @param url [String]
      # @return [Faraday::Response]
      def get(url)
        Faraday.get(with_circleci_token(url))
      end

      private

      # @param url [String]
      # @return [String]
      def with_circleci_token(url)
        "#{url}?circle-token=#{configuration.circleci_token}"
      end

      # @param build_number [Integer]
      # @return [String]
      def artifacts_url(build_number)
        [
          CIRCLECI_ENDPOINT,
          'project',
          configuration.vcs_type,
          configuration.user_name,
          configuration.repository_name,
          build_number,
          'artifacts'
        ].join('/')
      end

      # @param branch [String, nil]
      # @return [Array<Build>]
      def recent_builds(branch)
        JSON.parse(get(with_circleci_token(recent_builds_url(branch)) + '&limit=100').body).map do |hash|
          Build.new(hash['vcs_revision'], hash['build_num'], hash['previous']['build_num'])
        end
      end

      # @param branch [String, nil]
      # @return [String]
      def recent_builds_url(branch)
        elements = [
          CIRCLECI_ENDPOINT,
          'project',
          configuration.vcs_type,
          configuration.user_name,
          configuration.repository_name
        ]
        elements += ['tree', branch] if branch
        elements.join('/')
      end
    end
  end
end
