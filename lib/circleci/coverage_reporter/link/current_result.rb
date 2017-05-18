module CircleCI
  module CoverageReporter
    module Link
      class CurrentResult < AbstractCurrentResult
        # @note Override
        def initialize(path, html_file_name)
          @html_file_name = html_file_name
          super(path)
        end

        # @note Implement {AbstractResult#coverage}
        # @return [Float]
        def coverage
          Float::NAN
        end

        # @note Override {AbstractResult#pretty_coverage}
        def pretty_coverage
          ''
        end

        private

        attr_reader :html_file_name
      end
    end
  end
end
