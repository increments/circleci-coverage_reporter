module CircleCI
  module CoverageReporter
    # @attr coverage [Float]
    # @attr url [String] URL for coverage index.html
    Result = Struct.new(:coverage, :url) do
      # @return [String]
      def pretty_coverage
        "#{coverage.round(2)}%"
      end
    end
  end
end
