require 'faraday'

require_relative 'artifact'

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
          configuration.project,
          build_number,
          'artifacts'
        ].join('/')
      end
    end
  end
end
