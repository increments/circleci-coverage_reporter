require_relative 'coverage_reporter/client'
require_relative 'coverage_reporter/configuration'
require_relative 'coverage_reporter/errors'
require_relative 'coverage_reporter/runner'

require_relative 'coverage_reporter/flow/reporter'
require_relative 'coverage_reporter/link/reporter'
require_relative 'coverage_reporter/rubycritic/reporter'
require_relative 'coverage_reporter/simplecov/reporter'

module CircleCI
  module CoverageReporter
    class << self
      # Setters for shared global objects
      # @api private
      attr_writer :client, :configuration
    end

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
