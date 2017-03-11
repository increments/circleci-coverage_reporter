module CircleCI
  module CoverageReporter
    class Configuration
      DEFAULT_VCS_TYPE = 'github'.freeze

      # @return [String] CircleCI API token
      attr_accessor :circleci_token

      attr_writer :vcs_type

      # @return [String] repository owner name
      attr_accessor :user_name

      # @return [String] repository name
      attr_accessor :project

      # @return [String]
      def vcs_type
        @vcs_type || DEFAULT_VCS_TYPE
      end
    end
  end
end
