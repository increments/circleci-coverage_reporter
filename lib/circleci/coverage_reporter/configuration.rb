require_relative 'reporters/flow'
require_relative 'reporters/rubycritic'
require_relative 'reporters/simplecov'

module CircleCI
  module CoverageReporter
    class Configuration
      DEFAULT_REPORTERS = [
        Reporters::SimpleCov.new,
        Reporters::Flow.new,
        Reporters::RubyCritic.new
      ].freeze
      DEFAULT_VCS_TYPE = 'github'.freeze

      attr_accessor :circleci_token, :vcs_token
      attr_writer :artifacts_dir, :base_revision, :current_build_number, :current_revision, :previous_build_number,
                  :reporters, :repository_name, :template, :template_safe_mode, :user_name, :vcs_type

      # @return [String]
      def project
        "#{user_name}/#{repository_name}"
      end

      # @return [Array<Reporters::Base>]
      def reporters
        @reporters ||= DEFAULT_REPORTERS.dup
      end

      # @return [String]
      def vcs_type
        @vcs_type ||= DEFAULT_VCS_TYPE
      end

      # @return [String]
      def artifacts_dir
        @artifacts_dir ||= ENV['CIRCLE_ARTIFACTS']
      end

      # @return [String]
      def base_revision
        @base_revision ||= `git merge-base origin/master HEAD`.strip
      end

      # @return [Integer]
      def current_build_number
        @current_build_number ||= ENV['CIRCLE_BUILD_NUM']
      end

      # @return [String]
      def current_revision
        @current_revision ||= ENV['CIRCLE_SHA1']
      end

      # @return [Integer, nil]
      def previous_build_number
        @previous_build_number ||= ENV['CIRCLE_PREVIOUS_BUILD_NUM']&.to_i
      end

      # @return [String]
      def repository_name
        @repository_name ||= ENV['CIRCLE_PROJECT_REPONAME']
      end

      # @return [String]
      def user_name
        @user_name ||= ENV['CIRCLE_PROJECT_USERNAME']
      end

      # @return [void]
      def dump # rubocop:disable AbcSize
        puts <<~TEXT
          Configuration         | Value
          ----------------------|----------------------------------------------------------------------------
          artifacts_dir         | #{artifacts_dir.inspect}
          base_revision         | #{base_revision.inspect}
          circleci_token        | #{circleci_token[-4..-1].rjust(40, '*').inspect}
          current_build_number  | #{current_build_number.inspect}
          current_revision      | #{current_revision.inspect}
          previous_build_number | #{previous_build_number.inspect}
          reporters             | #{reporters.inspect}
          repository_name       | #{repository_name.inspect}
          user_name             | #{user_name.inspect}
          vcs_token             | #{vcs_token[-4..-1].rjust(40, '*').inspect}
          vcs_type              | #{vcs_type.inspect}
        TEXT
      end
    end
  end
end
