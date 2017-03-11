module CircleCI
  module CoverageReporter
    # @abstract Subclass and override {#coverage} to implement a custom Result class.
    class AbstractResult
      # @return [Float]
      def coverage
        raise NotImplementedError
      end
    end
  end
end
