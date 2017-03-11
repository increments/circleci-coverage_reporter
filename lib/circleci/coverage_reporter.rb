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

    # @return [Integer]
    def self.base_build_number
      client.build_number_by_revision(`git merge-base origin/master HEAD`.strip, branch: 'master')
    end
  end
end
