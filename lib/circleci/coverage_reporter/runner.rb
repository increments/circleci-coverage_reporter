require_relative 'github_client'

module CircleCI
  module CoverageReporter
    class Runner
      # @return [void]
      def run
        reports = reporters.map { |reporter| reporter.report(base_build, previous_build) }
        vcs_client.create_comment(reports)
      end

      private

      # @return [AbstractVCSClient]
      def vcs_client
        case client.configuration.vcs_type
        when 'github'
          GitHubClient.new(client.configuration.vcs_token)
        else
          raise NotImplementedError
        end
      end

      # @return [Build, nil]
      def base_build
        @base_build ||= client.single_build(base_build_number)
      end

      # @return [Build, nil]
      def previous_build
        @previous_build ||= client.single_build(previous_build_number)
      end

      # @return [Client]
      def client
        CoverageReporter.client
      end

      # @return [String, nil]
      def base_revision
        client.configuration.base_revision
      end

      # @return [Integer, nil]
      def previous_build_number
        client.configuration.previous_build_number
      end

      # @return [Array<AbstractReporter>]
      def reporters
        client.configuration.reporters
      end

      # @return [Integer, nil]
      def base_build_number
        return if client.configuration.base_revision == client.configuration.current_revision
        @base_build_number ||= client.build_number_by_revision(base_revision, branch: 'master')
      end
    end
  end
end
