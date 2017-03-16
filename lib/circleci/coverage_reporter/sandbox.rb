require_relative '../coverage_reporter'
require_relative 'client'
require_relative 'configuration'

module CircleCI
  module CoverageReporter
    # A sandbox isolates the enclosed code into an environment that looks 'new'
    # meaning globally accessed objects are reset for the duration of the sandbox.
    #
    # @note This module is not normally available. You must require
    #   `circleci/coverage_reporter/sandbox` to load it.
    module Sandbox
      # Execute a provided block with CircleCI::CoverageReporter global objects(
      # configuration, client) reset.
      #
      # @yield [Configuration]
      # @return [void]
      def self.sandboxed
        orig_config = CoverageReporter.configuration
        orig_client = CoverageReporter.client

        CoverageReporter.configuration = Configuration.new
        CoverageReporter.client = Client.new

        yield CoverageReporter.configuration
      ensure
        CoverageReporter.configuration = orig_config
        CoverageReporter.client = orig_client
      end
    end
  end
end
