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
    end
  end
end
