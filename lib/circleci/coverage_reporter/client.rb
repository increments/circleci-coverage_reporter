require 'faraday'

require_relative 'artifact'
require_relative 'build'
require_relative 'errors'

module CircleCI
  module CoverageReporter
    class Client
      CIRCLECI_ENDPOINT = 'https://circleci.com/api/v1.1'.freeze

      # @param build_number [Integer, nil]
      # @return [Build, nil]
      # @raise [RequestError]
      def single_build(build_number)
        return unless build_number
        resp = get(single_build_url(build_number))
        body = JSON.parse(resp.body)
        raise RequestError.new(body['message'], resp) unless resp.success?
        create_build(body)
      end

      # @param build_number [Integer]
      # @return [Array<Artifact>]
      # @raise [RequestError]
      def artifacts(build_number)
        resp = get(artifacts_url(build_number))
        body = JSON.parse(resp.body)
        raise RequestError.new(body['message'], resp) unless resp.success?
        body.map(&method(:create_artifact))
      end

      # @param revision [String]
      # @param branch [String, nil]
      # @return [Integer, nil]
      def build_number_by_revision(revision, branch: nil)
        build = recent_builds(branch).find { |recent_build| recent_build.match?(revision) }
        build ? build.build_number : nil
      end

      # @param url [String]
      # @param params [Hash]
      # @return [Faraday::Response]
      def get(url, params = {})
        params['circle-token'] = configuration.circleci_token
        Faraday.get(url + '?' + params.map { |key, value| "#{key}=#{value}" }.join('&'))
      end

      private

      # @return [Configuration]
      def configuration
        CoverageReporter.configuration
      end

      # @param build_number [Integer]
      # @return [String]
      def artifacts_url(build_number)
        [
          CIRCLECI_ENDPOINT,
          'project',
          configuration.vcs_type,
          configuration.project,
          build_number,
          'artifacts'
        ].join('/')
      end

      # @param branch [String, nil]
      # @return [Array<Build>]
      # @raise [RequestError]
      def recent_builds(branch)
        resp = get(recent_builds_url(branch), limit: 100)
        body = JSON.parse(resp.body)
        raise RequestError.new(body['message'], resp) unless resp.success?
        body.map(&method(:create_build))
      end

      # @param branch [String, nil]
      # @return [String]
      def recent_builds_url(branch)
        elements = [
          CIRCLECI_ENDPOINT,
          'project',
          configuration.vcs_type,
          configuration.project
        ]
        elements += ['tree', branch] if branch
        elements.join('/')
      end

      # @param build_number [Integer]
      # @return [String]
      def single_build_url(build_number)
        [
          CIRCLECI_ENDPOINT,
          'project',
          configuration.vcs_type,
          configuration.project,
          build_number
        ].join('/')
      end

      # @param hash [Hash]
      # @return [Artifact]
      def create_artifact(hash)
        Artifact.new(hash['path'], hash['pretty_path'], hash['node_index'], hash['url'])
      end

      # @param hash [Hash]
      # @return [Build]
      def create_build(hash)
        Build.new(hash['vcs_revision'], hash['build_num'])
      end
    end
  end
end
