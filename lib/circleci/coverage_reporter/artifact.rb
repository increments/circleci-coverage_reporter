module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI artifact
    #
    # @attr path [String] abstract path to the artifact in CircleCI container
    # @attr url [String] URL of the artifact
    # @attr node_index [Integer] the ID of the artifact's container
    Artifact = Struct.new(:path, :url, :node_index) do
      # @param value [String]
      # @param node_index [Integer, nil]
      # @return [Boolean]
      def match?(value, node_index: nil)
        path.end_with?(value) && (node_index.nil? || self.node_index == node_index)
      end

      # @return [String] content of the artifact
      def body
        @body ||= CoverageReporter.client.get(url).body
      end
    end
  end
end
