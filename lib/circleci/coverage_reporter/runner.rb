require_relative 'github_client'

module CircleCI
  module CoverageReporter
    class Runner
      # @return [void]
      def run
        reports = reporters.map { |reporter| reporter.report(base_build, previous_build) }
        vcs_client.create_comment(reports.map(&:to_s).join("\n"))
      end

      # @return [void]
      def dump
        puts <<~EOF
          Runner            | Value
          ------------------|-----------------------------------------------------------------------------------
          base_build        | #{base_build.inspect}
          base_build_number | #{base_build_number.inspect}
          previous_build    | #{previous_build.inspect}
        EOF
      end

      private

      # @return [AbstractVCSClient]
      def vcs_client
        case configuration.vcs_type
        when 'github'
          GitHubClient.new(configuration.vcs_token)
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

      # @return [Configuration]
      def configuration
        CoverageReporter.configuration
      end

      # @return [String, nil]
      def base_revision
        configuration.base_revision
      end

      # @return [Integer, nil]
      def previous_build_number
        configuration.previous_build_number
      end

      # @return [Array<AbstractReporter>]
      def reporters
        configuration.reporters
      end

      # @return [Integer, nil]
      def base_build_number
        return if configuration.base_revision == configuration.current_revision
        @base_build_number ||= client.build_number_by_revision(base_revision, branch: 'master')
      end
    end
  end
end
