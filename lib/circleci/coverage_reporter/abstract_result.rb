module CircleCI
  module CoverageReporter
    # @abstract Subclass and override {#coverage} to implement a custom Result class.
    class AbstractResult
      # @return [Float]
      def coverage
        raise NotImplementedError
      end

      # @return [String] URL for coverage index.html
      def url
        raise NotImplementedError
      end

      # @return [String]
      def pretty_coverage
        "#{coverage.round(2)}%"
      end
    end
  end
end
