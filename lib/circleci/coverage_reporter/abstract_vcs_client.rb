module CircleCI
  module CoverageReporter
    # @abstract Subclass and override {#create_comment} to implement a custom VCS client class.
    class AbstractVCSClient
      # @param token [String]
      def initialize(token)
        @token = token
      end

      # @param reports [Array<Report>]
      # @return [void]
      def create_comment(reports) # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end

      private

      attr_reader :token
    end
  end
end
