module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI build
    Build = Struct.new(:vcs_revision, :build_number) do
      # @param revision [String]
      # @return [Boolean]
      def match?(revision)
        vcs_revision.start_with?(revision)
      end

      # @return [Array<Artifact>]
      def artifacts
        @artifacts ||= CoverageReporter.client.artifacts(build_number)
      end
    end
  end
end
