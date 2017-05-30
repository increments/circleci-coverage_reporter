module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI artifact
    #
    # @attr path [String] abstract path to the artifact in CircleCI container
    # @attr url [String] URL of the artifact
    Artifact = Struct.new(:path, :url) do
      # @return [Boolean]
      def end_with?(value)
        path.end_with?(value)
      end

      # @return [String] content of the artifact
      def body
        @body ||= CoverageReporter.client.get(url).body
      end
    end
  end
end
