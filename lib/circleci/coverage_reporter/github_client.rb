require_relative 'abstract_vcs_client'

module CircleCI
  module CoverageReporter
    class GitHubClient < AbstractVCSClient
      # @note Implement {AbstractVCSClient#create_comment}
      # @param reports [Array<Report>]
      # @return [void]
      def create_comment(reports)
        Faraday.new(url: 'https://api.github.com').post do |req|
          req.url ['/repos', configuration.project, 'commits', configuration.current_revision, 'comments'].join('/')
          req.headers['Authorization'] = "token #{token}"
          req.headers['Content-Type'] = 'application/json'
          req.body = JSON.generate(body: reports.join("\n"))
        end
      end

      private

      # @return [Client]
      def configuration
        CoverageReporter.client.configuration
      end
    end
  end
end
