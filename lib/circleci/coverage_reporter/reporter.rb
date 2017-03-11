module CircleCI
  module CoverageReporter
    # @abstract Subclass and override {#build_by_build_number} and {#build_by_current_artifac}
    #   to implement a custom Reporter class.
    class Reporter
      # @param build_number [Integer, nil]
      # @return [Result, nil]
      def build_by_build_number(build_number) # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end

      # @return [Result]
      def build_by_current_artifact
        raise NotImplementedError
      end

      # @param base_build_number [Integer, nil]
      # @param previous_build_number [Integer, nil]
      def report(base_build_number, previous_build_number)
        Report.new(
          current: build_by_current_artifact,
          base: build_by_build_number(base_build_number),
          previous: build_by_build_number(previous_build_number)
        )
      end

      private

      # @return [Client]
      def client
        CoverageReporter.client
      end
    end
  end
end
