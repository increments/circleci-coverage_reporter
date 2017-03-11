module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI build
    Build = Struct.new(:vcs_revision, :build_num, :previous_build_num) do
      # @param revision [String]
      # @return [Boolean]
      def match?(revision)
        vcs_revision.start_with?(revision)
      end
    end
  end
end
