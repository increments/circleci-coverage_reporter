require_relative 'reporters/simplecov'

module CircleCI
  module CoverageReporter
    class Configuration
      DEFAULT_REPORTERS = [Reporters::SimpleCov.new].freeze
      DEFAULT_VCS_TYPE = 'github'.freeze

      attr_accessor :artifacts_dir, :base_revision, :circleci_token, :previous_build_number, :repository_name, :user_name

      attr_writer :reporters, :vcs_type

      # @return [Array<Reporters::BaseReporter>]
      def reporters
        @reporters ||= DEFAULT_REPORTERS
      end

      # @return [String]
      def vcs_type
        @vcs_type ||= DEFAULT_VCS_TYPE
      end
    end
  end
end
