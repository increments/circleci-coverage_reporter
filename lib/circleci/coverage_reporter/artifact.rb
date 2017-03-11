module CircleCI
  module CoverageReporter
    # Encapsulate a CircleCI artifact
    Artifact = Struct.new(:path, :pretty_path, :node_index, :url) do
      # @return [Boolean]
      def end_with?(value)
        pretty_path.end_with?(value)
      end

      # @return [String]
      def body
        @body ||= CoverageReporter.client.get(url).body
      end
    end
  end
end
