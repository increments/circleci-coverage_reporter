require_relative 'abstract_vcs_client'
require_relative 'errors'

module CircleCI
  module CoverageReporter
    class GitHubClient < AbstractVCSClient
      # @note Implement {AbstractVCSClient#create_comment}
      # @param reports [Array<Report>]
      # @return [void]
      # @raise [RequestError]
      def create_comment(reports)
        resp = request(reports)
        body = JSON.parse(resp.body)
        raise RequestError.new(body['message'], resp) unless resp.success?
      end

      private

      # @param reports [Array<Report>]
      # @return [Faraday::Response]
      def request(reports)
        Faraday.new(url: 'https://api.github.com').post do |req|
          req.url ['/repos', configuration.project, 'commits', configuration.current_revision, 'comments'].join('/')
          req.headers['Authorization'] = "token #{token}"
          req.headers['Content-Type'] = 'application/json'
          req.body = JSON.generate(body: reports.join("\n"))
        end
      end

      # @return [Configuration]
      def configuration
        CoverageReporter.configuration
      end
    end
  end
end
