module CircleCI
  module CoverageReporter
    # @abstract Subclass and override {#build_by_build_number} to implement a custom Reporter class.
    class Reporter
      # @param build_number [Integer, nil]
      # @return [Result, nil]
      def build_by_build_number(build_number) # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end
    end
  end
end
