require_relative 'current_result'

module CircleCI
  module CoverageReporter
    module Link
      class Reporter < AbstractReporter
        attr_reader :name

        # @param path [String, nil] relative path from artifacts dir to coverage directory
        # @param file_name [String] file name
        # @param name [String] reporter name
        def initialize(path, file_name, name: nil)
          @path = path
          @file_name = file_name
          @name = name || file_name
        end

        private

        # @note Implement {AbstractReporter#create_build_result}
        # @param _build [Build, nil]
        # @return [nil]
        def create_build_result(_build)
          nil
        end

        # @note Implement {AbstractReporter#create_current_result}
        # @return [CurrentResult]
        def create_current_result
          CurrentResult.new(path, @file_name)
        end
      end
    end
  end
end
