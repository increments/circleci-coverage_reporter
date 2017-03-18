require_relative 'flow/reporter'
require_relative 'rubycritic/reporter'
require_relative 'simplecov/reporter'

module CircleCI
  module CoverageReporter
    class Configuration
      DEFAULT_REPORTERS = [
        SimpleCov::Reporter.new,
        Flow::Reporter.new,
        RubyCritic::Reporter.new
      ].freeze
      DEFAULT_TEMPLATE = <<-'ERB'.freeze
<%- reports.each do |report| -%>
<%
  link = "[#{report.reporter.name}](#{report.current_result.url})"
  emoji = report.base_diff.nil? || report.base_diff.nan? || report.base_diff.round(2).zero? ? nil : report.base_diff.positive? ? ' :chart_with_upwards_trend:' : ' :chart_with_downwards_trend:'
  base_progress = report.base_diff ? "[master](#{report.base_result.url}): #{report.pretty_base_diff}" : nil
  branch_progress = report.branch_diff ? "[previous](#{report.previous_result.url}): #{report.pretty_branch_diff}" : nil
  progresses = [base_progress, branch_progress].compact
  progress = progresses.empty? ? nil : " (#{progresses.join(', ')})"
-%>
<%= link %>: <%= report.current_result.coverage.round(2) %>%<%= emoji %><%= progress %>
<%- end -%>
      ERB
      DEFAULT_TEMPLATE_TRIM_MODE = '-'.freeze
      DEFAULT_VCS_TYPE = 'github'.freeze

      attr_accessor :circleci_token, :vcs_token
      attr_writer :artifacts_dir, :base_revision, :current_build_number, :current_revision, :previous_build_number,
                  :reporters, :repository_name, :template, :template_safe_mode, :template_safe_mode, :user_name, :vcs_type

      # @return [String]
      def project
        "#{user_name}/#{repository_name}"
      end

      # @return [Array<AbstractReporter>]
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
        @previous_build_number ||= ENV['CIRCLE_PREVIOUS_BUILD_NUM'] && ENV['CIRCLE_PREVIOUS_BUILD_NUM'].to_i
      end

      # @return [String]
      def repository_name
        @repository_name ||= ENV['CIRCLE_PROJECT_REPONAME']
      end

      # @return [String]
      def template
        @template ||= DEFAULT_TEMPLATE
      end

      # @return [String, nil]
      def template_trim_mode
        @template_trim_mode ||= DEFAULT_TEMPLATE_TRIM_MODE
      end

      # @return [String]
      def user_name
        @user_name ||= ENV['CIRCLE_PROJECT_USERNAME']
      end

      # @return [void]
      def dump # rubocop:disable AbcSize
        puts <<-EOF
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
        EOF
      end
    end
  end
end
