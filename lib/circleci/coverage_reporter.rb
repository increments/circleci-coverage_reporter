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
      dump
      Runner.new.run
    end

    # @return [void]
    def self.dump # rubocop:disable AbcSize
      puts <<-EOF
Configuration         | Value
----------------------|----------------------------------------------------------------------------
artifacts_dir         | #{configuration.artifacts_dir.inspect}
base_revision         | #{configuration.base_revision.inspect}
circleci_token        | #{configuration.circleci_token[-4..-1].rjust(40, '*').inspect}
current_build_number  | #{configuration.current_build_number.inspect}
current_revision      | #{configuration.current_revision.inspect}
previous_build_number | #{configuration.previous_build_number.inspect}
reporters             | #{configuration.reporters.inspect}
repository_name       | #{configuration.repository_name.inspect}
user_name             | #{configuration.user_name.inspect}
vcs_token             | #{configuration.vcs_token[-4..-1].rjust(40, '*').inspect}
vcs_type              | #{configuration.vcs_type.inspect}
      EOF
    end
  end
end
