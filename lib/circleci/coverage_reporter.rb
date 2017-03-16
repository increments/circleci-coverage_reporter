require_relative 'coverage_reporter/client'
require_relative 'coverage_reporter/configuration'
require_relative 'coverage_reporter/errors'
require_relative 'coverage_reporter/runner'

module CircleCI
  module CoverageReporter
    # @return [Configuration]
    def self.configuration
      @configuration ||= Configuration.new
    end

    # @return [Client]
    def self.client
      @client ||= Client.new
    end

    # Yields the global configuration to a block.
    #
    # @yield [Configuration]
    def self.configure
      yield configuration if block_given?
    end

    # @return [void]
    def self.run
      configuration.reporters.select!(&:active?)
      configuration.dump
      raise NoActiveReporter if configuration.reporters.empty?
      Runner.new.tap(&:dump).run
    end
  end
end
