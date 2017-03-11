require_relative 'reporters/simplecov'

module CircleCI
  module CoverageReporter
    class Configuration
      DEFAULT_VCS_TYPE = 'github'.freeze
      DEFAULT_REPORTERS = [Reporters::SimpleCov.new].freeze

      # @return [String] CircleCI API token
      attr_accessor :circleci_token

      attr_writer :vcs_type

      # @return [String] repository owner name
      attr_accessor :user_name

      # @return [String] repository name
      attr_accessor :project

      attr_writer :reporters

      # @return [String]
      def vcs_type
        @vcs_type || DEFAULT_VCS_TYPE
      end

      # @return [Array<Reporters::BaseReporter>]
      def reporters
        @reporters || DEFAULT_REPORTERS
      end
    end
  end
end
