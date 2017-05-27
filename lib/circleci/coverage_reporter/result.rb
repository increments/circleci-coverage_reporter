module CircleCI
  module CoverageReporter
    class Result
      attr_reader :coverage, :url

      # @param coverage [Float]
      # @param url [String] URL for coverage index.html
      def initialize(coverage, url)
        @coverage = coverage
        @url = url
      end

      # @return [String]
      def pretty_coverage
        "#{coverage.round(2)}%"
      end
    end
  end
end
