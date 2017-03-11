require_relative 'coverage_reporter/configuration'
require_relative 'coverage_reporter/client'

module CircleCI
  module CoverageReporter
    # @return [Configuration]
    def self.configuration
      @configuration ||= Configuration.new
    end

    # @return [Client]
    def self.client
      @client ||= Client.new(configuration)
    end

    # Yields the global configuration to a block.
    #
    # @yield [Configuration]
    def self.configure
      yield configuration if block_given?
    end
  end
end
