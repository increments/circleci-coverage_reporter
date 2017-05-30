module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI artifact
    #
    # @attr path [String]
    # @attr url [String]
    Artifact = Struct.new(:path, :url) do
      # @return [Boolean]
      def end_with?(value)
        path.end_with?(value)
      end

      # @return [String]
      def body
        @body ||= CoverageReporter.client.get(url).body
      end
    end
  end
end
