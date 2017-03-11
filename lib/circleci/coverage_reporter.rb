require_relative 'coverage_reporter/configuration'
require_relative 'coverage_reporter/client'
require_relative 'coverage_reporter/runner'

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

    # @return [void]
    def self.run
      Runner.new.run
    rescue
      dump
      raise
    end

    # @return [void]
    def self.dump
      puts <<-EOF
  CircleCI::CoverageReporter.configure do |config|
    config.base_revision = '#{configuration.base_revision}'
    config.current_build_number = '#{configuration.current_build_number}'
    config.current_revision = '#{configuration.current_revision}'
    config.previous_build_number = '#{configuration.previous_build_number}'
    config.repository_name = '#{configuration.repository_name}'
    config.user_name = '#{configuration.user_name}'
    config.vcs_type = '#{configuration.vcs_type}'
  end
      EOF
    end
  end
end
